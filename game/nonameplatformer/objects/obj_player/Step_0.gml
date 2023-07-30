
scr_player_movement();

if keyboard_check_pressed(ord("G")) {
	room_speed = 5;
}
if keyboard_check_pressed(ord("H")) {
	room_speed = 60;
}

if (isJumping) && (!isGrounded) counter++;
if (isGrounded) counter = 0;