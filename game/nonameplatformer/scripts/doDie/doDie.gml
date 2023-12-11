function doDie() {

	switch(object_index) {
		
		case obj_player:

			state = playerState.dead;
			hsp = -hsp * 2;
			vsp = -vsp * 2;
			grav = 0;
			
		break;
		
	}

}