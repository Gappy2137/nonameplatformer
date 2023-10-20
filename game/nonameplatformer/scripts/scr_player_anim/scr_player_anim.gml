function scr_player_anim() {

	//idle
	//moving
	//jump vsp < 0
	//jump vsp ~ 0
	//jump vsp > 0
	
	//todo-------
	//sliding hsp > base spd
	//swinging
	//walljump
	
	/*
	anim_frame += anim_speed;
	if anim_frame > anim_frame_num{
		anim_frame = 0;
	}
	
	anim_frame_action += anim_speed_action;
	if anim_frame_action > (anim_frame_action_num + .9){
		anim_frame_action = anim_frame_action_num;
	}
	*/
	
	// Polar gear
	// Idle - 4 frames
	// Run - 6 frames
	// Jump - 3 frames (vsp < 0) (vsp ~ 0) (vsp > 0)
	// Wallkick - 1 frame
	
	// Headwear off
	//
	//
	//
	//
	
	switch(state) {
	
		case playerState.idle:
		
			spriteInd = idleSprite;
			animFrameNum = 4;
			animSpeed = 0.08;
			
			animFrame += animSpeed;
			if (animFrame >= animFrameNum) {
				animFrame = frac(animFrame);
			}
		
		break;
		case playerState.walking:
		
			if (isSkidding) {
				
				spriteInd = idleSprite;
				animFrameNum = 1;
				animSpeed = 0;
				animFrame = 2;
				
			} else {
			
				if (isJumping) {
					
					spriteInd = jumpSprite;
					animFrameNum = 1;
					animSpeed = 0;
					
					if (vsp < 0) {

						animFrame = 0;
					
					} else if (vsp > 0) {
					
						animFrame = 2;
					
					}
					
					if ( (vsp > -.2) && (vsp < .2) ) {
					
						animFrame = 1;
					
					}
					
					if (wallJumpTrigger) && (hsp != 0)
						facing = sign(hsp);
					
				} else {
				
					if (isFalling) {
						
						spriteInd = jumpSprite;
						animFrameNum = 1;
						animSpeed = 0;
						animFrame = 2;
						
					} else {
						
						if (vsp == 0) {
						
							spriteInd = runSprite;
							animFrameNum = 6;
							animSpeed = abs(hsp / 10);
						
							animFrame += animSpeed;
							if (animFrame >= animFrameNum) {
								animFrame = frac(animFrame);
							}
						
						} else {
						
							spriteInd = jumpSprite;
							animFrameNum = 1;
							animSpeed = 0;
							animFrame = 2;
						
						}
						
					}
				
				}
			
			}
			

		
		break;
		case playerState.wallslide:
		
			spriteInd = wallslideSprite;
			animFrameNum = 1;
			animSpeed = 0;
		
		break;
		
	
	}

}