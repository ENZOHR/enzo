function selectOption(a){
	var opcije = '';
	
	for(i=0;i<regionsHR.length;i++){
		opcije += '<optgroup label=' + regionsHR[i] + '>';
		for(j=0;j<regionsCity[i+1].length;j++){
			opcije += '<option value="' + (i+1) + '_' + j + '">' + regionsCity[i+1][j] +'</option>';
		}
	}
	
	
	$('#'+ a).append(opcije);
}