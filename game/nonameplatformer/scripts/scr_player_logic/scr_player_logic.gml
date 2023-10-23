function scr_player_logic() {

	if (x < -16) || (x > room_width + 16) || (y < -16) || (y > room_height + 16)
		if (state != playerState.dead)
			doDie();

}