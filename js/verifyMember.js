$(document).ready(function(){
	secretKey = 0;
	$('#autoRez').click(function(){
		link = $('#linkVer').val();
		var a = $('#OIB').val();
		var b = $('#secKey').val();
		$('.autorization .overlay').css({'display':'block'});	
		podaciA = '&type=verifyAutorization';
		podaciA += '&link=' + link;
		podaciA += '&oib=' + a;
		podaciA += '&secKey=' + b;	
		request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: podaciA,
			success:function(data){
				if(data.length==32){
					secretKey = data;
					setTimeout(function(){
						$('.autorization .over').css({'display':'block'});	
						$('.autorization .overlay').css({'display':'none'});	
						$('.new-pass-box .over').css({'display':'none'});
					},300);
				} else {
					$('.autorization .overlay').css({'display':'none'});	
				}
			}
		});
	});
	$('#sPass').click(function(){
		$('.new-pass-box .overlay').css({'display':'block'});		
		link = $('#linkVer').val();
		pass = $('#pwdUser').val();		
		podaci = '&type=pwdConfirm';
		podaci += '&link=' + link;
		podaci += '&pass=' + pass;		
		podaci += '&sec=' + secretKey;		
		request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: podaci,
			success:function(data){
				if(data=='1'){
					$('.new-pass-box').append('<div class="over"></div>');
					$('.new-pass-box .overlay').remove();
					$('.sec-q .over').remove();
				}
			}
		});
	});	
	$('.sec-q .btn').click(function(){
		link = $('#linkVer').val();
		secQ = $('.sec-q .secQ').val();
		secA = $('.sec-q .secA').val();
		
		podaciS = '&type=secQ';
		podaciS += '&link=' + link;
		podaciS += '&sec1=' + secQ;
		podaciS += '&sec2=' + secA;
		podaciS += '&sec=' + secretKey;
		
		request = $.ajax({
			type:'POST',
			url: 'includes/ajax.php',
			data: podaciS,
			success:function(data){
				if(data=='1'){
					window.location.replace('login.php');
				};
			}
		});
	});
	$('#OIB').keyup(function(event){
		var a = $(this).val().length;		
		if(a>=11) validY(this);
		else validN(this);
	});
	$('#pwdUser1').keyup(function(event){
		var a = $(this).val().length;		
		if(a>=6) validY(this);
		else validN(this);
		
		checkPass();
	});
	$('#pwdUser').keyup(function(event){
		var a = $(this).val().length;		
		if(a>=6) validY(this);
		else validN(this);
		
		checkPass();
	});
	function checkPass(){
		var a = $('#pwdUser1').val();
		var b = $('#pwdUser').val();
	
		if(a==b){
			$('#sPass').val('Spremi lozinku');
			if(a.length >= 6 & b.length >= 6) $('#sPass').removeClass('disabled');
			else $('#sPass').addClass('disabled');
		} else {
			$('#sPass').addClass('disabled');
			$('#sPass').val('Lozinke se ne poklapaju');
		}

	}
	function validY(a){
		$(a).removeClass('alert-warning');
		$(a).addClass('alert-success');
		$(a).addClass('valid');
	}
	function validN(a){
		$(a).removeClass('alert-success');
		$(a).removeClass('valid');
		$(a).addClass('alert-warning');
	}
	$('#OIB').keyup(function(event){	
		var value = $(this).val();
		if(value.length == 11) {oib = 1;validY(this);}
		else if(value.length > 11) return $(this).val(value.substr(0,value.length-1));
		else if(value.length < 11){oib = 0;validN(this);}

		checkAutorez();
	});
	$('#secKey').keyup(function(event){	
		var value = $(this).val();
		if(value.length == 8) {skey = 1;validY(this);}
		else if(value.length > 8) return $(this).val(value.substr(0,value.length-1));
		else if(value.length < 8){skey = 0;validN(this);}	
		
		checkAutorez();
	});
	
	function checkAutorez(){
		if($('#OIB').hasClass('valid') && $('#secKey').hasClass('valid')) $('#autoRez').removeClass('disabled');
	}
	$('.lettO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^a-zA-ZŠĐČĆŽšđčćž ]/g, function(str) {return ''; } ));
	});
	$('.numberO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^0-9]/g, function(str) {return ''; } ));
	});
	$('.combO').keyup(function(event){
		var th = $(this);
		th.val(th.val().replace(/[^0-9a-zA-ZŠĐČĆŽšđčćž /]/g, function(str) {return ''; } ));
	});
	
});