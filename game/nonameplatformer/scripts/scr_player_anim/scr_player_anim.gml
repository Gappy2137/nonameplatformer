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
	
	if (obj_game.roomTrigger) exit;
	
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
		case playerState.dead:
		
			spriteInd = deadSprite;
			animFrameNum = 1;
			animSpeed = 0;
		
		break;
	}

	if (inAir) {
	
		if ( (vsp > -.2) && (vsp < .2) ) {
		
			juiceT = 0;
		
		}
	
		if (vsp < -.2) {
			
			juiceTSpeed = 0.075;
			if (juiceT >= .75) juiceT = .75; else juiceT += juiceTSpeed;
			
			var squish = animcurve_channel_evaluate(curveJumpUp, juiceT) * 4;
			
			// Left
			juicePos[0][0] = squish;
			juicePos[3][0] = squish;
						
			// Right
			juicePos[1][0] = -squish;
			juicePos[2][0] = -squish;
						
			// Up
			juicePos[0][1] = -squish;
			juicePos[1][1] = -squish;
						
			// Down
			juicePos[2][1] = squish;
			juicePos[3][1] = squish;
		
		}
		
		if (vsp > .2) {
			
			juiceTSpeed = 0.05;
			if (juiceT >= .5) juiceT = .5; else juiceT += juiceTSpeed;
			
			var squish = animcurve_channel_evaluate(curveJumpUp, juiceT) * 4;
			
			// Left
			juicePos[0][0] = squish;
			juicePos[3][0] = squish;
						
			// Right
			juicePos[1][0] = -squish;
			juicePos[2][0] = -squish;
						
			// Up
			juicePos[0][1] = -squish;
			juicePos[1][1] = -squish;
						
			// Down
			juicePos[2][1] = squish;
			juicePos[3][1] = squish;
			
		}
	
	}
	
	if (landed) && (!inAir) {
		
		juiceTSpeed = 0.1;
		
		if (juiceT >= 1) {
			
			juiceT = 1;
			landed = false;
			
		} else {
			
			juiceT += juiceTSpeed;
			landingAnim = true;
			
		}
			
		var squish = animcurve_channel_evaluate(curveJumpUp, juiceT) * (y / yprevious) * 5;
			
		// Left
		juicePos[0][0] = -squish;
		juicePos[3][0] = -squish;
						
		// Right
		juicePos[1][0] = squish;
		juicePos[2][0] = squish;
						
		// Up
		juicePos[0][1] = squish;
		juicePos[1][1] = squish;
						
		// Down
		//juicePos[2][1] = squish;
		//juicePos[3][1] = squish;
	
	}

}