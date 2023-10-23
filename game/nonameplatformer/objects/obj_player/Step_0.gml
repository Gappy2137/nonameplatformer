sprPos[0] = [-sprOffset, -sprOffset];
sprPos[1] = [+sprOffset, -sprOffset];
sprPos[2] = [+sprOffset, +sprOffset];
sprPos[3] = [-sprOffset, +sprOffset];

// Process logic
scr_player_logic();

// Process movement
scr_player_movement();

// Process animations
scr_player_anim();

if (!landingAnim)
	landed = false;

//if (isJumping) && (!isGrounded) counter++;
//if (isGrounded) counter = 0;
/*
if (_prev < 0) _prev = 0;
if (_prev >= 1000) _prev = 1000;

if (mouse_check_button(mb_right)){
	
	rewind = true;

}else{

	rewind = false;

}

if (rewind) {
	if (_prev > 0) && (_prev < array_length(xPrev)) {
		x = xPrev[_prev];
		y = yPrev[_prev];
	}

}
*/