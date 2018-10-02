$(document).ready(function(){

	checBox();	
	
	$('.priceCon').click(function(){
		checBox();
		var a = $(this).parent().parent().children('input').val();
		if(a > 0){
			if(this.checked){
				$(this).parent().parent().children('input').attr('readonly','readonly');
				$(this).parent().parent().parent().children('.letOver').append('<div class="over" style="background:rgba(255,255,255,0.4);"></div>');

				checBox();
			} else {
				$(this).parent().parent().children('input').removeAttr('readonly');
				$(this).parent().parent().parent().children('.letOver').children('.over').remove();
				
			}			
		} else return false;
	});
	
	$('.conAll').click(function(){
		checBox();
	});
	
	$('.counter').keyup(function(){		
		var a = $(this).data('max');
		var b = $(this).val();		
		if( b > a ) $(this).val(a);		
	});
	$('.counter').blur(function(){		
		var a = $(this).data('min');
		var b = $(this).val();		
		if( b < a ) $(this).val(a);		
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
	
	$('#ulica').keyup(function(event){
		var a = $(this).val().length;
		if(a>=1){ulica=1;validY(this);}
		else{ulica=0;validN(this);}
	});
	
	

});


function checBox(){	
	$('.priceCon').each(function(){	
		if(this.checked);
		else {$('.saveServicesAll').addClass('disabled');return false;}
		if($('#tnc').prop('checked')==true && $('#ug').prop('checked')==true && $('#iii1').prop('checked')==true && $('#iii2').prop('checked')==true) $('.saveServicesAll').removeClass('disabled');
	});
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
	function validateEmail(email){ 
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(email);
	} 