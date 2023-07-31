
if (!rewind) {
	xPrev[_prev] = x;
	yPrev[_prev] = y;
	_prev++;
	if (_prev >= 1000) _prev = 0;
}else{
_prev--;	
}