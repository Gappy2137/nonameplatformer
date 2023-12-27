function doJump() {
	
	switch(object_index) {
		
		case obj_player:
		
			y--;
			justJumped = true;
			inAir = true;
			isJumping = true;
			isGrounded = false;
			isFalling = false;
			juiceT = 0.2;
			audio_play_sound(snd_jump, 1, false, .5, 0, random_range(0.8, 1.2));
		
		break;
		
	}
	
}