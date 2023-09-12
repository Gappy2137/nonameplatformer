
scr_player_movement();

if keyboard_check_pressed(ord("G")) {
	game_set_speed(5, gamespeed_fps);
	physics_world_update_speed(game_get_speed(gamespeed_fps));
}
if keyboard_check_pressed(ord("H")) {
	game_set_speed(60, gamespeed_fps);
	physics_world_update_speed(game_get_speed(gamespeed_fps));
}

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