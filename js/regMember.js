$(document).ready(function(){

	$('.takeSer').click(function(){
		$('.over.overob').css({display:'block'});		
		var podaci = $('#regMemberForm').serialize();
		podaci += '&type=regMember';
		
		request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: podaci,
			success:function(data){
				if(data=='1'){
					$('.over.overob .success').css({display:'block'});
				} else{
					$('.over.overob .failed').css({display:'block'});
				};
			}
		});	
		return false;
	});	
	
	$('.over.overob .failed .btn-danger').click(function(){
		$('.over.overob').css({display:'none'});	
		$('.over.overob .failed').css({display:'none'});
	});
	
	$('.over.overob .success .btn-success').click(function(){
		location.reload();
	});
	
	$("#unReg").keyup(function() 
	{ 
		var searchid = $(this).val();
		var dataString = 'type=unReg';
		dataString += '&search='+ searchid;
		if(searchid!='')
		{
			request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: dataString,
			success:function(data){
				$("#result").html(data).show();
			}
			});
		}return false;    
	});
	
	$('#zupanija').change(function(){
		var zupanija = 'type=getLocations&id=' + this.value;
		$("#grad").children('option').remove();
		
		request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: zupanija,
			success:function(data){
				$("#grad").append(data);
			}
		});
	});
	
	$(document).on('click','.autoC',function(){
		var a = $(this).data('id');
		var podaci = '&type=autoComplete&id=' + a;		
		request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: podaci,
			success:function(data){
				var result = eval(data);
				$('#naziv').val(result[0][2]);
				$('#ulica').val(result[0][7]);
				$('#licenca').val(result[0][0]);
				$('#email1').val(result[0][17]);
				$('#email').val(result[0][17]);
				$('#zupanija').val(result[0][18]);
				setTimeout(function(){
					$('#grad').val(result[0][19]);
					$('#grad').change();
				},1000);
				if(result[0][9]=="") $('#kontaktm').val(result[0][8]);
				else $('#kontaktm').val(result[0][9]);
				$('#naziv').keyup();
				$('#ulica').keyup();
				$('#licenca').keyup();
				$('#email1').keyup();
				$('#email').keyup();
				$('#kontaktm').keyup();	
				$('#zupanija').change();
			}
		});
	});
	
	jQuery(document).click(function(e) { 
		var $clicked = $(e.target);
		if (!$clicked.hasClass("unRegistered")){
		jQuery("#result").fadeOut(); 
		}
	});
	
	$('#unReg').click(function(){
		jQuery("#result").fadeIn();
	});
	
	oib = 0;
	naziv = 0;
	ulica = 0;
	zupanija = 0;
	grad = 0;
	licenca = 0;
	email1 = 0;
	email = 0;
	mob = 0;
	
	$('#oib').keyup(function(event){	
		var value = $(this).val();
		if(value.length == 11) {oib = 1;validY(this);}
		else if(value.length > 11) return $(this).val(value.substr(0,value.length-1));
		else if(value.length < 11){oib = 0;validN(this);}	
	});
	$('#PIN').keyup(function(event){	
		var value = $(this).val();
		if(value.length == 8) {validY(this);}
		else if(value.length > 11) return $(this).val(value.substr(0,value.length-1));
		else if(value.length < 11){validN(this);}	
	});
	$('#naziv').keyup(function(event){
		var a = $(this).val().length;
		if(a>=2){naziv=1;validY(this);}
		else{naziv=0;validN(this);}
	});
	$('#ulica').keyup(function(event){
		var a = $(this).val().length;
		if(a>=1){ulica=1;validY(this);}
		else{ulica=0;validN(this);}
	});
	$('#zupanija').change(function(){
		var a = $(this).val();
		if(a>0){zupanija=1;validY(this);}
		else{zupanija=0;validN(this);}
	});
	$('#grad').change(function(){
		var a = $(this).val();
		if(a>0){grad=1;validY(this);}
		else{grad=0;validN(this);}
	});
	$('#licenca').keyup(function(){
		var th = $(this);
		th.val(th.val().replace(/[^PF 0-9 \- \/]/g, function(str) {return ''; } ));
		
		if(th.val().length > 6){validY(this);licenca=1;}
		else{validN(this);licenca=0;}
	});
	$('.lettO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^a-zA-ZŠĐČĆŽšđčćž ]/g, function(str) {return ''; } ));
	});
	$('.emailO1').keyup(function(event){
		var a = validateEmail($(this).val());
		if(a==true){validY(this);email1=1;}
		else {validN(this);email1=0;}
	});
	$('.emailO').keyup(function(event){
		var a = validateEmail($(this).val());
		var b = $('#email1').val();
		var c = $(this).val();
		if(a==true && b==c){validY(this);email=1;}
		else {validN(this);email=0;}
	});
	$('.numberO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^0-9]/g, function(str) {return ''; } ));
	});
	$('.combO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^0-9a-zA-ZŠĐČĆŽšđčćž /]/g, function(str) {return ''; } ));
	});
	$('.mobO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^0-9 \/\-\+ ]/g, function(str) {return ''; } ));
		
		if($(this).val().length > 7){validY(this);mob=1;}
		else{validN(this);mob=0;}
	});
	$('.validate').focus(function(){
		if($(this).hasClass('valid')) return;
		else $(this).addClass('alert-warning');
	});
	$('.validate').focusout(function(){
		$(this).removeClass('alert-success');
	});
	function validateEmail(email){ 
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(email);
	} 
	function validY(a){
		$(a).removeClass('alert-warning');
		$(a).addClass('alert-success');
		$(a).addClass('valid');
		
		if(oib == 1 & naziv == 1 & ulica == 1 & zupanija == 1 & grad == 1 & licenca ==1 &	email1 == 1 & email == 1 & mob == 1) $('.takeSer').removeClass('disabled');
		else $('.takeSer').addClass('disabled');
	}
	function validN(a){
		$(a).removeClass('alert-success');
		$(a).removeClass('valid');
		$(a).addClass('alert-warning');
	}
});