function scr_player_movement() {
	
	if (!instance_exists(obj_hook)) exit;

	var keyDown	 =			keyboard_check(ord("S"));
	var keyLeft	 =			keyboard_check(ord("A"));
	var keyRight =			keyboard_check(ord("D"));
	var keyUp =				keyboard_check(ord("W"));
	
	var keyDownPressed =	keyboard_check_pressed(ord("S"));

	var keyJump =			keyboard_check_pressed(vk_space);
	var keyJumpReleased =	keyboard_check_released(vk_space);
	var keyJumpDown =		keyboard_check(vk_space);

	var horKeypress = keyRight - keyLeft;
	var verKeypress = keyDown - keyUp;
		
	if (offHookTrigger) {
		
		state = playerState.offhook;
		
	} else {
		
		if ( (hsp == 0) && (vsp == 0) )
			state = playerState.idle;
		else if ( (hsp != 0) || (vsp != 0) )
			state = playerState.walking;

	}
	
	switch(state) {
	
		case playerState.idle:
		case playerState.walking:
		
			if (isGrounded) {
	
				accel = accelGround;
			
				if (abs(hsp) > spdBase)
					deccel = deccelGround * .5;
				else
					deccel = deccelGround;
	
			} else {
		
				accel = accelAir;
				deccel = deccelAir;
		
			}
		
		break;
		
		case playerState.offhook:
		
			accel = accelAir;
			deccel = deccelHook;
		
		break;
	
	}


	if (horKeypress != 0) {
		
		if ( (state != playerState.offhook) 
		|| ( (abs(hsp) > spdBase) && (state != playerState.offhook) ) )
			hsp = lerp(hsp, spd * horKeypress, accel);
		else {
			hsp = lerp(hsp, clamp(hspAtRelease, spd, hspMax) * horKeypress, accel * ( (abs(hsp) > spdBase) ? .1 : .25 ) );
		}
		
		facing = horKeypress;
		
		if (abs(frac(hsp)) > .99) 
			hsp = round(hsp);

	} else {
		
		if (state != playerState.offhook) {
			
			if (abs(hsp) > spdBase)
				hsp = lerp(hsp, spdBase - .1, deccel * 0.75);
			else
				hsp = lerp(hsp, 0, deccel); 
			
		}

	}
	
	if ( (( (keyLeft) && (hsp > 0.1) )
	|| ( (keyRight) && (hsp < 0.1) )) )
	&& (!((keyRight) && (keyLeft))) {

		isSkidding = true;
	
	}
	
	if (isSkidding) {
	
		skidTime++;
		
		if (skidTime >= skidTimeMax) {
		
			skidTime = 0;
			isSkidding = false;
		
		}
	
	}
	
	if (keyDownPressed) {
	
		if (jumpOffTime == 0)
			jumpOffTime = jumpOffMax;
	
	}
		
	if (jumpOffTime <= 0)
		jumpOffTime = 0;
	else
		jumpOffTime--;
		
	
	
	var semisolidCollision =  collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semisolid, true, false);
	var semiSlopeCollision =  collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semislope, true, false);
	
	if ( (instance_place(x, y + 1, par_solid))
	|| (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_slope, true, false)) )
	|| ( (vsp >= 0) && (semisolidCollision) && (bbox_bottom <= semisolidCollision.bbox_top) && (jumpOffTime == 0) )
	|| ( (vsp >= 0) && (semiSlopeCollision) && (bbox_bottom <= semiSlopeCollision.bbox_top) && (jumpOffTime == 0) ){
		
		isGrounded = true;
		inAir = false;
		jumpThreshold = 0;
		canJump = true;
		jumpTime = 0;
		isJumping = false;
		offHookTrigger = false;
		
	} else {
		
		isGrounded = false;
		
	}
	
	if (isGrounded) 
		coyoteTime = coyoteMax;
	
	// Blisko scian nie uzywamy ulamkowych czesci pozycji zeby nie bylo problemow z kolizjami
	
	//if (collision_rectangle(bbox_left - 1, bbox_bottom - 2, bbox_right + 1, bbox_bottom - 1, par_solid, false, false)) x = round(x);
	
	if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_solid, false, false)) y = round(y);
	if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semisolid, true, false)) y = round(y);
	
	isFalling = vsp > 0 ? true : false;
	
	if (hookedState == playerHookedState.pull)
		jumpForce = jumpForceBase * ((abs(hsp * hsp) * .01) + 1);
	else
		if (!isJumping)
			jumpForce = jumpForceBase * ((abs(hsp * hsp) * .04) + 1);
		
	jumpForce = clamp(jumpForce, 0, 5);

	if (jumpsLeft == 0) canJump = false;

	if (keyJump)
		jumpBuffer = jumpBufferMax;
	
	if (jumpBuffer > 0) {
		
		jumpBuffer--;
	
		if (canJump) && (!jumpTrigger)
			doJump();
	
	}
	
	if (isFalling) || (isGrounded) jumpTrigger = false;
	
	if (isJumping) jumpTime++; else jumpsLeft = jumpsMax;
	
	if (!isGrounded) {
		
		skidTime = 0;
		isSkidding = false;
		
		if ((jumpTime >= jumpTimeThreshold) || (!isJumping)) {
			
			inAir = true;
			if (!ignoreGravity)
				vsp += grav;
			
		}
		
		if (coyoteTime > 0) {
		
			coyoteTime--;
			
			if (!isJumping) {
			
				if (keyJump) && (!jumpTrigger)
					doJump();
				
			}
		
		}
		
		if (state == playerState.offhook) {
			
			grav = gravBase * ((isFalling) ? 1 : .65);
			
		} else {
			
			if (!isFalling) {
				
				if (abs(vsp) < 0.75) {
			
					grav = lerp(grav, gravBase / 4, 0.1);
			
				} else {
			
					grav = gravBase;
			
				}
				
			} else {
				
				grav = gravBase * 1.75;
				
			}
			
		}

	}// else grav = 0;
	
	if (justJumped) {
	
		jumpAccelTime--;
		
		if (jumpAccelTime <= 0) {
			
			jumpAccelTime = jumpAccelThreshold;
			justJumped = false;
		
		}
		
		vsp = lerp(vsp, -jumpForce, jumpAccel);
	
	}
	
	if (jumpsLeft <= 0) jumpsLeft = 0;
	
	if (!keyJumpDown) && (isJumping) {
		
		if (isJumping) && (!isFalling) && (!isGrounded) {
	
			jumpTime = jumpTimeThreshold;
			inAir = true;
			jumpAccelTime = jumpAccelThreshold;
			justJumped = false;
			vsp *= 0.75;
	
		}
		
	}
	
	hsp = clamp(hsp, -hspMax, hspMax);
	vsp = clamp(vsp, vspMin, vspMax);
	
	#region Hook
	
	/*
	if (offHookTrigger) {
	
		if (offHookTimer >= offHookTimerMax) {
		
			offHookTimer = 0;
			offHookTrigger = false;
			
			ignoreGravity = false;
		
		} else {
		
			//offHookTimer++;
			//grav *= 0.75;
			deccelHook = (-0.0005 * (hsp * hsp)) + .05;
			//ignoreGravity = true;
			//vsp = -1.25;
		
		}
	
	}
	*/
	
	#endregion
	
	// Ledge forgiveness
	
	if (horKeypress != 0)
	counter = abs(((spd * horKeypress) - hsp) * accel);
	
	if (isFalling) {
	
		if ( abs(hsp) > accel * 2 ) {
			
			var threshold = 4;
		
			var ledgeCol = collision_rectangle(bbox_left + hsp, bbox_bottom - threshold, bbox_right + hsp, bbox_bottom, par_solid, false, false);
			
			if (ledgeCol)
			&& (!object_is_ancestor(ledgeCol.object_index, par_slope)) { 
			
				var _height = (bbox_bottom - bbox_top);
				var emptyCol = collision_rectangle(bbox_left + hsp, bbox_top - threshold, bbox_right + hsp, bbox_bottom - threshold, par_solid, false, false);
			
				if (!emptyCol) {
					
					x += sign(hsp);
					y = ledgeCol.bbox_top - sprite_yoffset;
					
				}
			
			}
		
		}
	
	}
	
	var slopeCollisionHor = instance_place(x + hsp, y, par_slope);
	var slopeCollisionHorInv = instance_place(x + hsp, y, par_slope_inv);
	var semiSlopeCollisionHor = instance_place(x + hsp, y, par_semislope);
	
	if (instance_place(x, y + 1, par_slope))
	&& (!instance_place(x + hsp, y + 1, par_slope)) {
		
		var yplus = 0;
		
		while ( (!instance_place(x + round(hsp), y + yplus + 1, par_slope)) && (yplus <= abs(2*round(hsp))) )
			yplus++;
	    
		if !instance_place(x + hsp, y + yplus, par_solid) {
			
			y += yplus;

		}
		
	}
	
	if (slopeCollisionHor) {
	
		var yplus = 0;
		
		while ( (instance_place(x + hsp, y - yplus, par_slope)) && (yplus <= abs(2*hsp)) )
			yplus += 1;
	    
		if instance_place(x + hsp, y - yplus, par_solid) {
			
			while (!instance_place(x + sign(hsp), y, par_solid)) {
				x += sign(hsp);
			}
			
			hsp = 0;
			
		} else {
		
			y -= yplus;
			
		}
	
	}
	
	if (semiSlopeCollisionHor) {
	
		var yplus = 0;
		
		while ( (instance_place(x + hsp, y - yplus, par_semislope)) && (yplus <= abs(2*hsp)) )
			yplus += 1;
	    
		if instance_place(x + hsp, y - yplus, par_solid) {
			
			while (!instance_place(x + sign(hsp), y, par_solid)) {
				x += sign(hsp);
			}
			
			hsp = 0;
			
		} else {
		
			y -= yplus;
			
		}
	
	}
	
	var horCollision = instance_place(x + hsp, y, par_solid);
	
	if (horCollision) 
	&& (!object_is_ancestor(horCollision.object_index, par_slope))
	&& (!object_is_ancestor(horCollision.object_index, par_slope_inv)) {

		while (!instance_place(x + sign(hsp), y, par_solid)) {
			x += sign(hsp);
		}
			
		
		hsp = 0;
			
	}
	
	if (slopeCollisionHorInv) {
	
		var yplus = 0;
		
		while ( (instance_place(x + hsp, y + yplus, par_slope_inv)) && (yplus <= abs(2*hsp)) )
			yplus += 1;
	    
		if instance_place(x + hsp, y + yplus, par_solid) {
			
			while (!instance_place(x + sign(hsp), y, par_solid)) {
				x += sign(hsp);
			}
			
			hsp = 0;
			
		} else
		
			y += yplus;
	
	}
	
	x += hsp;
	
	if (isJumping) && (!isFalling) && (vsp < -0.05) {
			
		var bbox_half = (bbox_left + (bbox_right - bbox_left) / 2);		// position in world
		var wallPassThreshold = bbox_right - bbox_half;					// length
		var topThreshold = round(abs(vsp/2)) + 2;
		var topThresholdBlock = round(abs(vsp/2)) + 4;

		if (hsp <= 1) {
			
			var blockCol = collision_rectangle(bbox_left - wallPassThreshold, bbox_top - topThreshold, bbox_right - wallPassThreshold, bbox_bottom, par_solid, true, false);
			
			if (!blockCol) {
				
				var emptyCol = (collision_rectangle(bbox_left + wallPassThreshold, bbox_top - topThreshold, bbox_right + 1, bbox_bottom, par_solid, true, false));
				
				if (emptyCol)
				&& (!object_is_ancestor(emptyCol.object_index, par_slope))
				&& (!object_is_ancestor(emptyCol.object_index, par_slope_inv))
				
					x -= bbox_right - emptyCol.bbox_left;
	
			}
			
		}
		
		if (hsp >= -1) {
			
			var blockCol = collision_rectangle(bbox_left + wallPassThreshold, bbox_top - topThreshold, bbox_right + wallPassThreshold, bbox_bottom, par_solid, true, false);
			
			if (!blockCol) {
				
				var emptyCol = (collision_rectangle(bbox_left - 1, bbox_top - topThreshold, bbox_right - wallPassThreshold, bbox_bottom, par_solid, true, false));
				
				if (emptyCol)
				&& (!object_is_ancestor(emptyCol.object_index, par_slope))
				&& (!object_is_ancestor(emptyCol.object_index, par_slope_inv))
				
					x += emptyCol.bbox_right - bbox_left;
	
			}
			
		}
		
	}
	
	if (vsp > 0) && (jumpOffTime == 0) {
		
		if collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + (vsp), par_semisolid, true, false)
		|| collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + (vsp), par_semislope, true, false)
			if (vsp > 1) vsp = 1;
		
		if (collision_rectangle(bbox_left, bbox_bottom - 2.5, bbox_right, bbox_bottom, par_semisolid, true, false)) {
			y--;
			vsp = 0;
		}
		
		if ( (semisolidCollision) && (bbox_bottom <= semisolidCollision.bbox_top) )
		|| ( (semiSlopeCollision) && (bbox_bottom <= semiSlopeCollision.bbox_top) )
			vsp = 0;

	}

	
	var verCollision = instance_place(x, y + vsp, par_solid);
	
	if (verCollision) {
		
		while (!instance_place(x, y + sign(vsp), par_solid)) {
			y += sign(vsp);
		}
			
		vsp = 0;
			
	}
	
	y += vsp;

}