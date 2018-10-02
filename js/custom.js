$(document).ready(function(){
	
	var y = window.screen.availHeight;
	var x = window.screen.availWidth;
	
	if(y>200 && x>991) res = 1;
	else res = 0;
	
	var kv = document.getElementById('square');
	$('#kvadrati').slider({
		formater: function(value1) {
			kv.value = value1;
		}
	});
	
	$('.sliders').each(function(){
		var a = $(this).parent().parent().find('.counter');
		$(this).slider({
			formater: function(value1) {
				$(a).val(value1);
			}
		});
	});
	$('.disClick').click(function(){
		return false;
	});
	$('.first').val(0);
	
	// Homepage hover effect
	$('.featured-box').hover(
		function(){
			if($(this).hasClass('disabled')) return false;
			else $(this).removeClass('featured-box-simple');
		}, function(){
			if($(this).hasClass('disabled')) return false;
			else $(this).addClass('featured-box-simple');
	});
	
	// 1st step Homepage
	$('.mCall').click(function(){
		if($(this).hasClass('disabled')) return false;
		$('#chooseCer .tab-pane .overlay').eq(0).fadeIn();
		var title = $(this).children('h4').text();
		$('.modal-title').text(title);
		setTimeout(function(){
			
			$('.tab-content .tab-pane.active').removeClass('active');
			$('.tab-content .tab-pane').eq(1).addClass('active');
			$('#chooseCer .tab-pane .overlay').eq(0).fadeOut(200);		
		},700);
		
		if(res==1) return false;
	});
	
	// Navigation
	$('#mainGame .nav li a').click(function(){
		
		if($(this).hasClass('disabled')) return false;
		else {
			
			
		}
		
	});
	
	// Pick type of
	$('.vnch .btn.choice').click(function(){
		$('.vnch .btn.choice').removeClass('btn-primary');
		$(this).addClass('btn-primary');		
		
		$('.over').eq(0).fadeOut();
		
		if(res==1) return false;
	});	
	
	function chooseCity($a){
		var cities = regionsCity[$a];
		options1 = '<option value="0">Grad</option>';
		for(i=0;i<cities.length;i++){
			options1 += '<option value="' + (i+1) + '">' + cities[i] + '</option>';
		}
		$('.city').append(options1);
	}
	
	var options = '<option value="0">Županija</option>';
	for(i=0;i<regionsHR.length;i++){
		options += '<option value="' + (i+1) + '">' + regionsHR[i] + '</option>';
	}

	$('.regions').append(options);
	
	$('.regions').change(function(){
		$('.city').children('option').remove();
		chooseCity($(this).val());
		checkFields();
	});
	
	$('.city').change(function(){
		checkFields();
		$('.city').eq(1).val($(this).val());
	});
	
	function checkFields(){	
		var valReg = $('.regions').val();
		var valCit = $('.city').val();
		var valSqu = $('#square').val();	
		if(valReg != 0 && valCit != 0 && valSqu != 0) {
			$('.getList.disabled').removeClass('disabled');
		} else $('.getList').addClass('disabled');
	}
	
	// Get List
	$('.getList').click(function(){
	
		$('.overlay').eq(1).fadeIn();
		
		setTimeout(function(){
			
			$('.tab-content .tab-pane.active').removeClass('active');
			$('.tab-content .tab-pane').eq(2).addClass('active');
			$('#chooseCer .tab-pane .overlay').eq(1).fadeOut(200);		
		},700);
	
		if(res==1) return false;
	});	
	
	// Back to certificates
	$('#izCert').click(function(){
		$('.overlay').eq(1).fadeIn();
		
		setTimeout(function(){
			
			$('.tab-content .tab-pane.active').removeClass('active');
			$('.tab-content .tab-pane').eq(0).addClass('active');
			$('#chooseCer .tab-pane .overlay').eq(1).fadeOut(200);		
		},700);
	
		if(res==1) return false;		
	});
});