if (!array_length(drawArray)) exit;

var i = 0;

repeat(array_length(drawArray)) {
	
	drawArray[i].Step();
	
	if ( (drawArray[i].alpha <= 0) || (drawArray[i].size <= .2) ) {
	
		delete drawArray[i];
		array_delete(drawArray, i, 1);
		--i;
	
	}
	++i;
	
}