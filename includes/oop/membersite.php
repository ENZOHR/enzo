<?PHP
ob_start();
require_once("class.phpmailer.php");
class FGMembersite
{
    var $admin_email;
    var $from_address;
    
    var $username;
    var $pwd;
    var $database;
    var $tablename;
    var $connection;
    var $rand_key;
    
    var $error_message;
    
    //-----Initialization ------- PROMJENITI SITURL I CC MAIL UKLJUČITI PRILIKOM STAVLJANJA NA ENZO.HR
    function FGMembersite()
    {
        $this->siteurl = 'http://www.enzo.hr/';
        $this->sitename = 'ENZO.HR';
        $this->rand_key = '0iQx5oBk66oVZep';
    }
    
    function InitDB($host,$uname,$pwd,$database)
    {
        $this->db_host  = $host;
        $this->username = $uname;
        $this->pwd  = $pwd;
        $this->database  = $database;
    }
    
    function SetRandomKey($key)
    {
        $this->rand_key = $key;
    }
    
    //-------Registracija certifikatora ----------------------
	function registerMember($uid, $name, $street, $city, $license, $email, $mob, $activation_key, $activation, $tmp_pass)
	{		
		$reg = array($name, $uid, '0', '0', $street, $license, $mob, $email, 'N');
		$reg_1 = array($uid, 'member', $activation_key, $activation, $tmp_pass);
		
		foreach($reg as &$val){	$val = mysql_real_escape_string($val); }
		foreach($reg_1 as &$val_1){	$val_1 = mysql_real_escape_string($val_1); }
		
		$regSQL = implode('", "', $reg);
		$regSQL_1 = implode('", "', $reg_1);
		
		
		$query = 'INSERT INTO member (name, oib, member_type_id, location_id, street, apt_no, mob, email, active) VALUES ("' . $regSQL . '")';	
		$query_1 = 'INSERT INTO user (id,type,activation_key,activation,tmp_pass) VALUES("' . $regSQL_1 . '")';	
		if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }
        $result = mysql_query($query,$this->connection);
		if(!$result) return false;
        $result_1 = mysql_query($query_1,$this->connection);
        if(!$result_1) return false;
		
		return true;
	}
	
	//-------Potvrda putem maila ----------------------
	function registerMemberMail($email, $name, $act, $key){
		$mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($email,$name);
		
		$mailer->AddBCC('monitor@enzo.hr', 'Monitor Enzo');
        
        $mailer->Subject = "Aktivacija računa za ". $name ." | ".$this->sitename;

        $mailer->From = $this->GetFromAddress();  

		$mailer->AddEmbeddedImage('http://www.enzo.hr/img/enzo_logo.png', 'logo_2u', "enzo_logo.png");
        
        $mailer->Body ="Pozdrav ".$name." , \r\n\r\n".
        "U procesu je Vaša registracija na ".$this->sitename.".\r\n\n".
        "Molimo Vas da svoju registraciju završite klikom na sljedeći link : ". $this->siteurl ."verify.php?link=". $act . "\r\n\n" .
		"Vaš tajni ključ : " . $key . "\r\n\n" .
		"Tajni ključ Vam je potreban kako bi ste završili aktivaciju svog korisničkog računa. Molimo Vas da ga zabilježite kako bi ste ga mogli iskoristiti na gore navedenom linku. \r\n\n" .
        "Unaprijed zahvaljujemo,\r\n\n".
        "Enzo.hr";

        if(!$mailer->Send())
        {
            $this->HandleError("Failed sending user welcome email.");
            return false;
        }
        return true;	
	}
	
	function checkVerify($id){	
		$count = strlen($id);
		if($count != 32) return false;
		
		$query = 'SELECT id FROM user WHERE activation="' . $id . '" AND confirmed="N"';	
		if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }     
        $result = mysql_query($query,$this->connection);
		if(!$result)
        {
            $this->HandleError("Registracija certifikatora nije uspješno odrađena");
            return false;
        }
		$num_rows = mysql_num_rows($result);
		if($num_rows==1){
			return true;
		} else return false;
		
		return false;
	}
	
	function unReg($q){
		$q = mysql_real_escape_string($q);
		$query = "select id,naziv,email from member_tmp where naziv like '%$q%' or email like '%$q%' order by id LIMIT 5";
		if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }     
        $result = mysql_query($query,$this->connection);
		if(!$result)
        {
            $this->HandleError("Nemogu dohvatit certifikatore");
            return false;
        }		
		while($row = mysql_fetch_array($result)){		
			echo '<a href="#" class="list-group-item autoC" data-id="' . $row['id'] . '" ><strong>' . $row['naziv'] . '</strong> - ' . $row['email'] . '</a>';
		}	
	}
	
	function unReg_Auto($id){
		$q = mysql_real_escape_string($id);
		$query = "select member_tmp.*, region.id, location.id from member_tmp, region, location where member_tmp.id=$q AND zupanija=region.name AND grad=location.name";
		if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }     
        $result = mysql_query($query,$this->connection);
		if(!$result)
        {
            $this->HandleError("Nemogu dohvatit ovog certifikatora");
            return false;
        }		
		$print = array();
		while($row = mysql_fetch_array($result)){		
			$array[] = $row;
		}	
		echo json_encode($array);
	}
	
	function getServiceClass($id){
		$query = '
			SELECT member_service_class.*,offer_min, offer_max, service_class.name, service_class.id AS numb, service_class.service_id AS ser, service_type.name AS servis 
			FROM member_service_class, service_class, service_type
			WHERE member_id="' . $id . '" 
			AND service_class.active="Y"
			AND member_service_class.service_class_id=service_class.id AND service_type.id=service_class.service_id
			ORDER BY service_type.id ASC, service_class_id ASC, newV DESC	
		';
		if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }     
        $result = mysql_query($query,$this->connection);
		if(!$result)
        {
            return false;
        }
		$num_rows = mysql_num_rows($result);
		$naziv = '';
		while($row = mysql_fetch_array($result)){
			
			$ins='';
			if($row['offer']==0) $ins = 'first';			
			if($row['active']==='Y') $active = 'checked';
			else $active = '';
			if($naziv === $row['name']) {$row['name'] = '';};			
			$naziv = $row['name'];
			if($naziv==='') $style='style="margin-top:-40px;"';
			else $style='';
			if($row['newV']==='Y') $rb = 'NOVO';
			else if($row['newV']==='N') $rb = 'POSTOJEĆE';
			if($active==='checked'){
				$dis1 = 'readonly="readonly"';
				$over1 = '<div class="over" style="background:rgba(255,255,255,0.4);"></div>';
			} else {$dis1='';$over1='';}
		
			if(!isset($curr) || $curr!=$row['servis']){
				echo '<hr /><h4 style="text-align:left;">' . $row['servis'] . '</h4>';
			}
			
			if($row['newV']==='N' && $row['ser']==='1') $row['offer_max']=$row['offer_max']*1.2;
			else if($row['newV']==='N' && $row['ser']==='2') $row['offer_max']=$row['offer_max']*3.8;
			
			if($row['newV']==='N' && $row['ser']==='1' && $row['numb']==='1'){
				$row["offer_min"] = 600;
				$row["offer_max"] = 1200;
			}
			if($row['newV']==='N' && $row['ser']==='1' && $row['numb']==='2'){
				$row["offer_min"] = 725;
				$row["offer_max"] = 1450;
			}
			if($row['newV']==='N' && $row['ser']==='1' && $row['numb']==='3'){
				$row["offer_min"] = 1200;
				$row["offer_max"] = 2400;
			}
			if($row['newV']==='N' && $row['ser']==='2' && $row['numb']==='10'){
				$row["offer_min"] = 750;
				$row["offer_max"] = 1500;
			}
			if($row['newV']==='N' && $row['ser']==='2' && $row['numb']==='11'){
				$row["offer_min"] = 1650;
				$row["offer_max"] = 3300;
			}
			if($row['newV']==='N' && $row['ser']==='2' && $row['numb']==='12'){
				$row["offer_min"] = 2500;
				$row["offer_max"] = 5000;
			}
			
			
			$curr = $row['servis'];
			echo '<div '.$style.'>
				<p class="col-md-12" style="text-align:left;font-weight:bold;">' . $row["name"] . '</p><p class="col-md-2">
					'.$rb.' 
				</p><div class="col-md-4 letOver">'.$over1.'
					<input class="sliders slider_' . $row["id"] . '" id="' . $row["id"] . '" data-slider-id="cijena-' . $row["id"] . '" data-slider-tooltip="hide" type="text" data-slider-min="' . $row["offer_min"] . '" data-slider-max="' . $row["offer_max"] . '" data-slider-step="1" data-slider-value="'. $row["offer"] .'" value="0" />
				  </div><p class="col-md-6"> 
					<input data-min="' . $row["offer_min"] . '" data-max="' . $row["offer_max"] . '" '.$dis1.' type="number" name="sPrice['. $row["id"] .']" style="padding:0 5px;margin-bottom:15px;" value="'. $row["offer"] .'" class="col-md-3 price counter '.$ins.'"  /><span class="currency col-md-1" style="text-align: left; float: left;  display: block;  margin-left: -48px;  margin-top: 2px;">HRK</span>
					<label class="col-md-8" style="font-size:11px;line-height:10px;text-align:center;font-weight:normal;"><input type="checkbox" name="sPriceCheck['. $row["id"] .']" class="priceCon" '. $active .' /> Potvrđujem da sam ja postavio ovu cijenu.</label>		  
				  </p>
				  <p class="clear"></p></div>';
		}
		if($num_rows < 1) {echo '
			<div class="alert alert-warning">
				<strong>Pogreška !</strong> Molimo Vas da prvo izaberete usluge, te potom postavite cijene.<br />
				<a href="account_member.php?step=services">Izaberite usluge ovdje !</a>
			</div>
		';return 0;}
	}
	
	function listServices(){
		$query = 'SELECT id, name, service_type FROM service WHERE active="Y"';
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		if(!$result) return false;
		while($row = mysql_fetch_array($result)){
			echo '<optgroup label="' . $row['name'] . '">';
			$query_2 = 'SELECT id, name, new FROM service_class WHERE service_id=' . $row['id'] . ' AND active="Y" ORDER BY id DESC';
			$result_2 = mysql_query($query_2,$this->connection);
			if(!$result_2)
			{
			   return false;
			}
			while($row_2 = mysql_fetch_array($result_2)){
				if($row_2['new']==="N") echo '<option value="' . $row_2['id'] . '">' . $row_2['name'] . '</option>';
				else if($row_2['new']==="Y") echo '<option value="' . $row_2['id'] . '$100000' . $row_2['id'] . '" '.$selected.'>' . $row_2['name'] . '</option>';	
			}
		}
	}
	
	function listRegions(){
		$query = 'SELECT id, name FROM region WHERE active="Y"';
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		if(!$result) return false;
		echo '<option value="0">Županija</option>';
		while($row = mysql_fetch_array($result)){
			echo '<option value="' . $row['id'] . '">' . $row['name'] . '</option>';
		}
	}
	
	function getLocations($id){
		$query = 'SELECT id, name FROM location WHERE region_id=' . $id . ' AND active="Y" ORDER BY name ASC';
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		$opt = '<option value="0">Grad</option>';
		while($row = mysql_fetch_array($result)){
			$opt .= '<option value="' . $row['id'] . '">' . $row['name'] . '</option>';
		}
		echo $opt;
	}
	
	function listLocMult(){
		$query = 'SELECT id, name FROM region WHERE active="Y" ORDER BY id DESC';
		$query_1 = 'SELECT id, name, region_id FROM location WHERE active="Y" ORDER BY id DESC';
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		$result_1 = mysql_query($query_1,$this->connection);
		if(!$result || !$result_1) return false;
		while($row_1 = mysql_fetch_array($result_1)){
			$grad[] = $row_1;
		}
		while($row = mysql_fetch_array($result)){
			echo '<optgroup label="' . $row['name'] . '">';
			echo $grad[1]['name'];
			foreach ($grad as $key=>$value) {
				if($grad[$key]['region_id']===$row['id']){
					echo '<option value="' . $grad[$key]['id'] . '">' . $grad[$key]['name'] . '</option>';
				}
			}
		}

	}
	
	function listLocMultSelected(){
		$oib = isset($_SESSION['id'])?$_SESSION['id']:'';
		$id = $this->getMember($oib);
		if(!$id) return false;
		else{
			$query = 'SELECT id, name FROM region WHERE active="Y" ORDER BY id DESC';
			if(!$this->DBLogin()) return false;
			$result = mysql_query($query,$this->connection);
			
			while($row = mysql_fetch_array($result)){
				echo '<optgroup label="' . $row['name'] . '">';
				$query_1 = '
					SELECT location.id, name, region_id, (SELECT id FROM member_loc WHERE member_id='.$id[0]['id'].' AND location_id = location.id) AS selected
					FROM location WHERE region_id='. $row['id'];
				$result_1 = mysql_query($query_1,$this->connection);
				while($row_1 = mysql_fetch_array($result_1)){
					if(isset($row_1['selected'])) $selected = 'selected';
					else $selected = '';
					echo '<option value="'.$row_1['id'].'" '.$selected.'>'.$row_1['name'].'</option>';
				}				
			}
			return true;
		}
	}
	
	
	function listMemberServices(){
		$oib = isset($_SESSION['id'])?$_SESSION['id']:'';
		if(!$oib) return false;
		$query = 'SELECT id, name, service_type FROM service WHERE active="Y"';
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		if(!$result) return false;
		while($row = mysql_fetch_array($result)){
			echo '<optgroup label="' . $row['name'] . '">';
			$query_2 = 'SELECT id, name, new, (SELECT id FROM member_service_class WHERE user_id='.$oib.' AND member_service_class.service_class_id = service_class.id AND newV="N") AS selected FROM service_class WHERE service_id=' . $row['id'] . ' AND active="Y" ORDER BY id DESC';
			$result_2 = mysql_query($query_2,$this->connection);
			while($row_2 = mysql_fetch_array($result_2)){
				if($row_2['new']==="N"){
					if(isset($row_2['selected'])) $selected = 'selected';
					else $selected = '';
					echo '<option value="' . $row_2['id'] . '" '.$selected.'>' . $row_2['name'] . '</option>';			
				} else if($row_2['new']==="Y"){
					if(isset($row_2['selected'])) $selected = 'selected';
					else $selected = '';
					echo '<option value="' . $row_2['id'] . '$100000' . $row_2['id'] . '" '.$selected.'>' . $row_2['name'] . '</option>';			
				}
			}
		}
	}
	
	function registerMemberLocationsClear($id){
		$query = 'DELETE FROM member_loc WHERE member_id='. $id;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
	}
	
	function registerMemberServicesClear($id){
		$query = 'DELETE FROM member_service_class WHERE member_id='. $id;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
	}
	
	function getMember($id){
		$query = 'SELECT * FROM member WHERE oib=' . $id ;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		while($row = mysql_fetch_array($result)){
			$member[] = $row;
		}
		return $member;
	}	
	
	function regigisterMemberAddServices($oib, $id, array $services){
		foreach ($services as $ser) {
				if(strpos($ser,'$')){
					$ser = explode("$", $ser);	
					$query = 'INSERT INTO member_service_class (service_class_id, member_id, offer,currency, timestamp, user_id) VALUES (' . $ser[0] . ',' . $id . ',"0","HRK",now(),' . $oib . ')';
					if(!$this->DBLogin()) return false;
					$result = mysql_query($query,$this->connection);
					if(!$result) return false;
					$query = 'INSERT INTO member_service_class (service_class_id, member_id, offer, newV, currency, timestamp, user_id) VALUES (' . $ser[0] . ',' . $id . ',"0", "Y", "HRK",now(),' . $oib . ')';
					if(!$this->DBLogin()) return false;
					$result = mysql_query($query,$this->connection);
					if(!$result) return false;
				} else {
						$query = 'INSERT INTO member_service_class (service_class_id, member_id, offer, currency, timestamp, user_id) VALUES (' . $ser . ',' . $id . ',"0","HRK",now(),' . $oib . ')';
						if(!$this->DBLogin()) return false;
						$result = mysql_query($query,$this->connection);
						if(!$result) return false;
				}
		}
		return true;
	}
	
	function registerMemberLocations($id, array $regions){
		foreach($regions as $region)
		{
			$query = 'INSERT INTO member_loc (member_id, location_id) VALUES ('. $id .', '. $region .')';
			if(!$this->DBLogin()) return false;
			$result = mysql_query($query,$this->connection);
		}
		return true;
	}
	
	function saveServicesPrice(array $price, array $savePriceC, $id){
		foreach ($savePriceC as $key => $check) {
			if($check==='on'){
				$query = 'UPDATE member_service_class SET offer='. $price[$key] .', active="Y" 
						WHERE user_id='. $id .'
						AND id='. $key ;
				if(!$this->DBLogin()) return false;
				$result = mysql_query($query,$this->connection);
			} else{
				$query = 'UPDATE member_service_class SET active="N" 
						WHERE user_id='. $id .'
						AND id='. $key ;
				if(!$this->DBLogin()) return false;
				$result = mysql_query($query,$this->connection);
			}
		}
		return true;
	}
	
	function saveMemberTC($c1, $c2, $c3, $c4, $id){
		$query = 'UPDATE member SET con1="'. $c1 .'", con2="'. $c2 .'", con3="'. $c3 .'", con4="'. $c4 .'"  WHERE oib = '. $id;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		return true;
	}
	
	function getCon(){
		$id = isset($_SESSION['id'])?$_SESSION['id']:'';
		$query = 'SELECT con1, con2, con3, con4 FROM member  WHERE oib = '. $id;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		while($row = mysql_fetch_array($result)){
			$con[]=$row;
		}
		return $con;		
	}
	
	function checkActivationMember($id){
		$active = 0;
		$active1 = 0;
		$active2 = 0;
		$active3 = 0;		
		$query = 'SELECT active FROM member WHERE id=' . $id . ' LIMIT 0, 1' ;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		while($row = mysql_fetch_array($result)){
			if($row['active'] === 'Y') $active4 = 1;
			else $active4 = 0;
		}	
		$con = $this->getCon();		
		if($con[0]['con1']==='Y' && $con[0]['con2']==='Y' && $con[0]['con3']==='Y' && $con[0]['con4']==='Y') $active1 = 1;		
		$query = 'SELECT id FROM member_service_class WHERE member_id=' . $id . ' AND offer > 0 AND active="Y" LIMIT 0, 1' ;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		$num_rows = mysql_num_rows($result);
		if($num_rows > 0) $active2 = 1;		
		$query = 'SELECT id FROM member_loc WHERE member_id=' . $id . ' LIMIT 0, 1' ;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
		$num_rows = mysql_num_rows($result);
		if($num_rows > 0) $active3 = 1;		
		if($active1===1 && $active2===1 && $active3===1){
			if($active4===1) return 3;
			if($active4===0) return 1;
		}
		if($active4===1 && ($active1===0 || $active2===0 || $active3===0)){
			$query = 'UPDATE member SET active="N" WHERE id=' . $id;
			if(!$this->DBLogin()) return false;
			$result = mysql_query($query,$this->connection);
		}
		return 2;
	}
	
	function registerMemberActiveTurnO($id, $status){
		$query = 'UPDATE member SET active="'.$status.'" WHERE id=' . $id;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
	}
	
	function saveMemberAccountF($id, $mob, $email, $street){
		$mob = mysql_real_escape_string($mob);
		$email = mysql_real_escape_string($email);
		$street = mysql_real_escape_string($street);
		
		$var1='';
		$var2='';
		$var3='';
		
		if(isset($mob)) $var1 = 'mob="'.$mob . '", ';
		if(isset($email)) $var2 = 'email="'.$email . '", ';
		if(isset($email)) $var3 = 'street="'.$street . '" ';
		
		$query = 'UPDATE member SET ' . $var1 . '' . $var2 . '' . $var3 . ' WHERE id=' . $id ;
		if(!$this->DBLogin()) return false;
		$result = mysql_query($query,$this->connection);
	}
	
    function RegisterUser()
    {
        if(!isset($_POST['submitted']))
        {
           return false;
        }
        
        $formvars = array();
        
        if(!$this->ValidateRegistrationSubmission())
        {
            return false;
        }
        
        $this->CollectRegistrationSubmission($formvars);
        
        if(!$this->SaveToDatabase($formvars))
        {
            return false;
        }
        
        if(!$this->SendUserConfirmationEmail($formvars))
        {
            return false;
        }

        $this->SendAdminIntimationEmail($formvars);
        
        return true;
    }

    function ConfirmUser()
    {
        if(empty($_GET['code'])||strlen($_GET['code'])<=10)
        {
            $this->HandleError("Please provide the confirm code");
            return false;
        }
        $user_rec = array();
        if(!$this->UpdateDBRecForConfirmation($user_rec))
        {
            return false;
        }
        
        $this->SendUserWelcomeEmail($user_rec);
        
        $this->SendAdminIntimationOnRegComplete($user_rec);
        
        return true;
    }    
    
    function Login()
    {
        if(empty($_POST['username']))
        {
            $this->HandleError("UserName is empty!");
            return false;
        }
        
        if(empty($_POST['password']))
        {
            $this->HandleError("Password is empty!");
            return false;
        }
        
        $username = trim($_POST['username']);
        $password = trim($_POST['password']);
        
        if(!isset($_SESSION)){ session_set_cookie_params(0);session_start(); }
        if(!$this->CheckLoginInDB($username,$password))
        {
            return false;
        }
        
        $_SESSION[$this->GetLoginSessionVar()] = $username;
        
        return true;
    }
    
    function CheckLogin()
    {
         if(!isset($_SESSION)){ session_start(); }

         $sessionvar = $this->GetLoginSessionVar();
         
         if(empty($_SESSION[$sessionvar]))
         {
            return false;
         }
         return true;
    }
    
    function UserFullName()
    {
        return isset($_SESSION['name_of_user'])?$_SESSION['name_of_user']:'';
    }
    
    function UserEmail()
    {
        return isset($_SESSION['email_of_user'])?$_SESSION['email_of_user']:'';
    }
    
    function LogOut()
    {
        session_start();
        
        $sessionvar = $this->GetLoginSessionVar();
        
        $_SESSION[$sessionvar]=NULL;
        
        unset($_SESSION[$sessionvar]);
    }
    
    function EmailResetPasswordLink()
    {
        if(empty($_POST['email']))
        {
            $this->HandleError("Email is empty!");
            return false;
        }
        $user_rec = array();
        if(false === $this->GetUserFromEmail($_POST['email'], $user_rec))
        {
            return false;
        }
        if(false === $this->SendResetPasswordLink($user_rec))
        {
            return false;
        }
        return true;
    }
    
    function ResetPassword()
    {
        if(empty($_GET['email']))
        {
            $this->HandleError("Email is empty!");
            return false;
        }
        if(empty($_GET['code']))
        {
            $this->HandleError("reset code is empty!");
            return false;
        }
        $email = trim($_GET['email']);
        $code = trim($_GET['code']);
        
        if($this->GetResetPasswordCode($email) != $code)
        {
            $this->HandleError("Bad reset code!");
            return false;
        }
        
        $user_rec = array();
        if(!$this->GetUserFromEmail($email,$user_rec))
        {
            return false;
        }
        
        $new_password = $this->ResetUserPasswordInDB($user_rec);
        if(false === $new_password || empty($new_password))
        {
            $this->HandleError("Error updating new password");
            return false;
        }
        
        if(false == $this->SendNewPassword($user_rec,$new_password))
        {
            $this->HandleError("Error sending new password");
            return false;
        }
        return true;
    }
    
    function ChangePassword()
    {
        if(!$this->CheckLogin())
        {
            $this->HandleError("Not logged in!");
            return false;
        }
        
        if(empty($_POST['oldpwd']))
        {
            $this->HandleError("Old password is empty!");
            return false;
        }
        if(empty($_POST['newpwd']))
        {
            $this->HandleError("New password is empty!");
            return false;
        }
        
        $user_rec = array();
        if(!$this->GetUserFromEmail($this->UserEmail(),$user_rec))
        {
            return false;
        }
        
        $pwd = trim($_POST['oldpwd']);
        
        if($user_rec['password'] != md5($pwd))
        {
            $this->HandleError("The old password does not match!");
            return false;
        }
        $newpwd = trim($_POST['newpwd']);
        
        if(!$this->ChangePasswordInDB($user_rec, $newpwd))
        {
            return false;
        }
        return true;
    }
    
    //-------Public Helper functions -------------
    function GetSelfScript()
    {
        return htmlentities($_SERVER['PHP_SELF']);
    }    
    
    function SafeDisplay($value_name)
    {
        if(empty($_POST[$value_name]))
        {
            return'';
        }
        return htmlentities($_POST[$value_name]);
    }
    
    function RedirectToURL($url)
    {
        header("Location: $url");
        exit;
    }
    
    function GetSpamTrapInputName()
    {
        return 'sp'.md5('KHGdnbvsgst'.$this->rand_key);
    }
    
    function GetErrorMessage()
    {
        if(empty($this->error_message))
        {
            return '';
        }
        $errormsg = nl2br(htmlentities($this->error_message));
        return $errormsg;
    }    
    //-------Private Helper functions-----------
    
    function HandleError($err)
    {
        $this->error_message .= $err."\r\n";
    }
    
    function HandleDBError($err)
    {
        $this->HandleError($err."\r\n mysqlerror:".mysql_error());
    }
    
    function GetFromAddress()
    {
        $from ="korisnicki.racun@enzo.hr";
        return $from;
    } 
    
    function GetLoginSessionVar()
    {
        $retvar = md5($this->rand_key);
        $retvar = 'usr_'.substr($retvar,0,10);
        return $retvar;
    }
    
    function CheckLoginInDB($username,$password)
    {
        if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }          
        $username = $this->SanitizeForSQL($username);
        $pwdmd5 = md5($password);
		
        $qry = "Select id,type from user where id=$username and pass='$pwdmd5' and confirmed='Y'";        
        $result = mysql_query($qry,$this->connection);        
        if(!$result || mysql_num_rows($result) <= 0)
        {
            $this->HandleError("Error logging in. The username or password does not match");
            return false;
        }        
        $row = mysql_fetch_assoc($result);
		      
        $_SESSION['id']  = $row['id'];
        $_SESSION['membership']  = $row['type']; 
        
        return true;
    }
	
	function getMembershipType(){
		return isset($_SESSION['membership'])?$_SESSION['membership']:'';
	}
	
	function getFullName($type, $id){
	
		if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }
		
		if($type=='member'){
			$qry = "Select name from $type where oib=$id"; 
		} else {
			$qry = "Select name from $type where id=$id";    
		}
		$result = mysql_query($qry,$this->connection);
		
		if(!$result || mysql_num_rows($result) <= 0)
        {
            $this->HandleError("Error logging in. The username or password does not match");
            return false;
        }
		$row = mysql_fetch_assoc($result);

		return $row['name'];	
	}
    
    function UpdateDBRecForConfirmation(&$user_rec)
    {
        if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }   
        $confirmcode = $this->SanitizeForSQL($_GET['code']);
        
        $result = mysql_query("Select name, email from $this->tablename where confirmcode='$confirmcode'",$this->connection);   
        if(!$result || mysql_num_rows($result) <= 0)
        {
            $this->HandleError("Wrong confirm code.");
            return false;
        }
        $row = mysql_fetch_assoc($result);
        $user_rec['name'] = $row['name'];
        $user_rec['email']= $row['email'];
        
        $qry = "Update $this->tablename Set confirmcode='y' Where  confirmcode='$confirmcode'";
        
        if(!mysql_query( $qry ,$this->connection))
        {
            $this->HandleDBError("Error inserting data to the table\nquery:$qry");
            return false;
        }      
        return true;
    }
    
    function ResetUserPasswordInDB($user_rec)
    {
        $new_password = substr(md5(uniqid()),0,10);
        
        if(false == $this->ChangePasswordInDB($user_rec,$new_password))
        {
            return false;
        }
        return $new_password;
    }
    
    function ChangePasswordInDB($user_rec, $newpwd)
    {
        $newpwd = $this->SanitizeForSQL($newpwd);
        
        $qry = "Update $this->tablename Set password='".md5($newpwd)."' Where  id_user=".$user_rec['id_user']."";
        
        if(!mysql_query( $qry ,$this->connection))
        {
            $this->HandleDBError("Error updating the password \nquery:$qry");
            return false;
        }     
        return true;
    }
    
    function GetUserFromEmail($email,&$user_rec)
    {
        if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }   
        $email = $this->SanitizeForSQL($email);
        
        $result = mysql_query("Select * from $this->tablename where email='$email'",$this->connection);  

        if(!$result || mysql_num_rows($result) <= 0)
        {
            $this->HandleError("There is no user with email: $email");
            return false;
        }
        $user_rec = mysql_fetch_assoc($result);

        
        return true;
    }
    
    function SendUserWelcomeEmail(&$user_rec)
    {
        $mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($user_rec['email'],$user_rec['name']);
        
        $mailer->Subject = "Welcome to ".$this->sitename;

        $mailer->From = $this->GetFromAddress();        
        
        $mailer->Body ="Hello ".$user_rec['name']."\r\n\r\n".
        "Welcome! Your registration  with ".$this->sitename." is completed.\r\n".
        "\r\n".
        "Regards,\r\n".
        "Webmaster\r\n".
        $this->sitename;

        if(!$mailer->Send())
        {
            $this->HandleError("Failed sending user welcome email.");
            return false;
        }
        return true;
    }
    
    function SendAdminIntimationOnRegComplete(&$user_rec)
    {
        if(empty($this->admin_email))
        {
            return false;
        }
        $mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($this->admin_email);
        
        $mailer->Subject = "Registration Completed: ".$user_rec['name'];

        $mailer->From = $this->GetFromAddress();         
        
        $mailer->Body ="A new user registered at ".$this->sitename."\r\n".
        "Name: ".$user_rec['name']."\r\n".
        "Email address: ".$user_rec['email']."\r\n";
        
        if(!$mailer->Send())
        {
            return false;
        }
        return true;
    }
    
    function GetResetPasswordCode($email)
    {
       return substr(md5($email.$this->sitename.$this->rand_key),0,10);
    }
    
    function SendResetPasswordLink($user_rec)
    {
        $email = $user_rec['email'];
        
        $mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($email,$user_rec['name']);
        
        $mailer->Subject = "Your reset password request at ".$this->sitename;

        $mailer->From = $this->GetFromAddress();
        
        $link = $this->GetAbsoluteURLFolder().
                '/resetpwd.php?email='.
                urlencode($email).'&code='.
                urlencode($this->GetResetPasswordCode($email));

        $mailer->Body ="Hello ".$user_rec['name']."\r\n\r\n".
        "There was a request to reset your password at ".$this->sitename."\r\n".
        "Please click the link below to complete the request: \r\n".$link."\r\n".
        "Regards,\r\n".
        "Webmaster\r\n".
        $this->sitename;
        
        if(!$mailer->Send())
        {
            return false;
        }
        return true;
    }
    
    function SendNewPassword($user_rec, $new_password)
    {
        $email = $user_rec['email'];
        
        $mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($email,$user_rec['name']);
        
        $mailer->Subject = "Your new password for ".$this->sitename;

        $mailer->From = $this->GetFromAddress();
        
        $mailer->Body ="Hello ".$user_rec['name']."\r\n\r\n".
        "Your password is reset successfully. ".
        "Here is your updated login:\r\n".
        "username:".$user_rec['username']."\r\n".
        "password:$new_password\r\n".
        "\r\n".
        "Login here: ".$this->GetAbsoluteURLFolder()."/login.php\r\n".
        "\r\n".
        "Regards,\r\n".
        "Webmaster\r\n".
        $this->sitename;
        
        if(!$mailer->Send())
        {
            return false;
        }
        return true;
    }    
    
    function ValidateRegistrationSubmission()
    {
        //This is a hidden input field. Humans won't fill this field.
        if(!empty($_POST[$this->GetSpamTrapInputName()]) )
        {
            //The proper error is not given intentionally
            $this->HandleError("Automated submission prevention: case 2 failed");
            return false;
        }
        
        $validator = new FormValidator();
        $validator->addValidation("name","req","Please fill in Name");
        $validator->addValidation("email","email","The input for Email should be a valid email value");
        $validator->addValidation("email","req","Please fill in Email");
        $validator->addValidation("username","req","Please fill in UserName");
        $validator->addValidation("password","req","Please fill in Password");

        
        if(!$validator->ValidateForm())
        {
            $error='';
            $error_hash = $validator->GetErrors();
            foreach($error_hash as $inpname => $inp_err)
            {
                $error .= $inpname.':'.$inp_err."\n";
            }
            $this->HandleError($error);
            return false;
        }        
        return true;
    }
    
    function CollectRegistrationSubmission(&$formvars)
    {
        $formvars['name'] = $this->Sanitize($_POST['name']);
        $formvars['email'] = $this->Sanitize($_POST['email']);
        $formvars['username'] = $this->Sanitize($_POST['username']);
        $formvars['password'] = $this->Sanitize($_POST['password']);
    }
    
    function SendUserConfirmationEmail(&$formvars)
    {
        $mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($formvars['email'],$formvars['name']);
        
        $mailer->Subject = "Your registration with ".$this->sitename;

        $mailer->From = $this->GetFromAddress();        
        
        $confirmcode = $formvars['confirmcode'];
        
        $confirm_url = $this->GetAbsoluteURLFolder().'/confirmreg.php?code='.$confirmcode;
        
        $mailer->Body ="Hello ".$formvars['name']."\r\n\r\n".
        "Thanks for your registration with ".$this->sitename."\r\n".
        "Please click the link below to confirm your registration.\r\n".
        "$confirm_url\r\n".
        "\r\n".
        "Regards,\r\n".
        "Webmaster\r\n".
        $this->sitename;

        if(!$mailer->Send())
        {
            $this->HandleError("Failed sending registration confirmation email.");
            return false;
        }
        return true;
    }
    function GetAbsoluteURLFolder()
    {
        $scriptFolder = (isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] == 'on')) ? 'https://' : 'http://';
        $scriptFolder .= $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']);
        return $scriptFolder;
    }
    
    function SendAdminIntimationEmail(&$formvars)
    {
        if(empty($this->admin_email))
        {
            return false;
        }
        $mailer = new PHPMailer();
        
        $mailer->CharSet = 'utf-8';
        
        $mailer->AddAddress($this->admin_email);
        
        $mailer->Subject = "New registration: ".$formvars['name'];

        $mailer->From = $this->GetFromAddress();         
        
        $mailer->Body ="A new user registered at ".$this->sitename."\r\n".
        "Name: ".$formvars['name']."\r\n".
        "Email address: ".$formvars['email']."\r\n".
        "UserName: ".$formvars['username'];
        
        if(!$mailer->Send())
        {
            return false;
        }
        return true;
    }
    
    function SaveToDatabase(&$formvars)
    {
        if(!$this->DBLogin())
        {
            $this->HandleError("Database login failed!");
            return false;
        }
        if(!$this->Ensuretable())
        {
            return false;
        }
        if(!$this->IsFieldUnique($formvars,'email'))
        {
            $this->HandleError("This email is already registered");
            return false;
        }
        
        if(!$this->IsFieldUnique($formvars,'username'))
        {
            $this->HandleError("This UserName is already used. Please try another username");
            return false;
        }        
        if(!$this->InsertIntoDB($formvars))
        {
            $this->HandleError("Inserting to Database failed!");
            return false;
        }
        return true;
    }
    
    function IsFieldUnique($formvars,$fieldname)
    {
        $field_val = $this->SanitizeForSQL($formvars[$fieldname]);
        $qry = "select username from $this->tablename where $fieldname='".$field_val."'";
        $result = mysql_query($qry,$this->connection);   
        if($result && mysql_num_rows($result) > 0)
        {
            return false;
        }
        return true;
    }
    
    function DBLogin()
    {

        $this->connection = mysql_connect($this->db_host,$this->username,$this->pwd);

        if(!$this->connection)
        {   
            $this->HandleDBError("Database Login failed! Please make sure that the DB login credentials provided are correct");
            return false;
        }
        if(!mysql_select_db($this->database, $this->connection))
        {
            $this->HandleDBError('Failed to select database: '.$this->database.' Please make sure that the database name provided is correct');
            return false;
        }
        if(!mysql_query("SET NAMES 'UTF8'",$this->connection))
        {
            $this->HandleDBError('Error setting utf8 encoding');
            return false;
        }
        return true;
    }    
    
    function Ensuretable()
    {
        $result = mysql_query("SHOW COLUMNS FROM $this->tablename");   
        if(!$result || mysql_num_rows($result) <= 0)
        {
            return $this->CreateTable();
        }
        return true;
    }
    
    function CreateTable()
    {
        $qry = "Create Table $this->tablename (".
                "id_user INT NOT NULL AUTO_INCREMENT ,".
                "name VARCHAR( 128 ) NOT NULL ,".
                "email VARCHAR( 64 ) NOT NULL ,".
                "phone_number VARCHAR( 16 ) NOT NULL ,".
                "username VARCHAR( 16 ) NOT NULL ,".
                "password VARCHAR( 32 ) NOT NULL ,".
                "confirmcode VARCHAR(32) ,".
                "PRIMARY KEY ( id_user )".
                ")";
                
        if(!mysql_query($qry,$this->connection))
        {
            $this->HandleDBError("Error creating the table \nquery was\n $qry");
            return false;
        }
        return true;
    }
    
    function InsertIntoDB(&$formvars)
    {
    
        $confirmcode = $this->MakeConfirmationMd5($formvars['email']);
        
        $formvars['confirmcode'] = $confirmcode;
        
        $insert_query = 'insert into '.$this->tablename.'(
                name,
                email,
                username,
                password,
                confirmcode
                )
                values
                (
                "' . $this->SanitizeForSQL($formvars['name']) . '",
                "' . $this->SanitizeForSQL($formvars['email']) . '",
                "' . $this->SanitizeForSQL($formvars['username']) . '",
                "' . md5($formvars['password']) . '",
                "' . $confirmcode . '"
                )';      
        if(!mysql_query( $insert_query ,$this->connection))
        {
            $this->HandleDBError("Error inserting data to the table\nquery:$insert_query");
            return false;
        }        
        return true;
    }
    function MakeConfirmationMd5($email)
    {
        $randno1 = rand();
        $randno2 = rand();
        return md5($email.$this->rand_key.$randno1.''.$randno2);
    }
    function SanitizeForSQL($str)
    {
        if( function_exists( "mysql_real_escape_string" ) )
        {
              $ret_str = mysql_real_escape_string( $str );
        }
        else
        {
              $ret_str = addslashes( $str );
        }
        return $ret_str;
    }
    
 /*
    Sanitize() function removes any potential threat from the
    data submitted. Prevents email injections or any other hacker attempts.
    if $remove_nl is true, newline chracters are removed from the input.
    */
    function Sanitize($str,$remove_nl=true)
    {
        $str = $this->StripSlashes($str);

        if($remove_nl)
        {
            $injections = array('/(\n+)/i',
                '/(\r+)/i',
                '/(\t+)/i',
                '/(%0A+)/i',
                '/(%0D+)/i',
                '/(%08+)/i',
                '/(%09+)/i'
                );
            $str = preg_replace($injections,'',$str);
        }

        return $str;
    }    
    function StripSlashes($str)
    {
        if(get_magic_quotes_gpc())
        {
            $str = stripslashes($str);
        }
        return $str;
    }   
}
?>