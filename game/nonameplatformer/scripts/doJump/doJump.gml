function doJump() {
	
	switch(object_index) {
		
		case obj_player:
		
			y--;
			justJumped = true;
			inAir = true;
			isJumping = true;
			isGrounded = false;
			isFalling = false;
			jumpsLeft--;
			jumpTrigger = true;
		
		break;
		
	}
	
}