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
	
	//--------------------------------------------------------------------------------
	// Grounded state
	
	var semisolidCollision =  collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semisolid, true, false);
	var semiSlopeCollision =  collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semislope, true, false);
	
	if ( (instance_place(x, y + 1, par_solid))
	|| (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_slope, true, false)) )
	|| ( (vsp >= 0) && (semisolidCollision) && (bbox_bottom <= semisolidCollision.bbox_top) && (jumpOffTime == 0) )
	|| ( (vsp >= 0) && (semiSlopeCollision) && (bbox_bottom <= semiSlopeCollision.bbox_top) && (jumpOffTime == 0) )
		isGrounded = true;
	 else
		isGrounded = false;
	
	if (isGrounded) {
	
		landed = true;
		
		// Landing frame
		justLanded = true;
		
		vsp = 0;
		inAir = false;
		jumpThreshold = 0;
		canJump = true;
		jumpTime = 0;
		isJumping = false;
		offHookTrigger = false;
		coyoteTime = coyoteMax;
		jumps = 0;
		jumpTrigger = false;
		jumpsMax = 1;
		
	}
	
	//--------------------------------------------------------------------------------
	
	if (obj_game.roomTrigger) exit;
	
	isFalling = vsp > 0 ? true : false;
		
	if (state != playerState.dead) {
		
		if (obj_hook.state == hookState.embedded) {
	
			state = playerState.onhook;
	
		} else {
		
			if (offHookTrigger) {
		
				state = playerState.offhook;
		
			} else {
			
				if ( (hsp == 0) && (vsp == 0) )
					state = playerState.idle;
				else if ( (hsp != 0) || (vsp != 0) )
					state = playerState.walking;

			}
		
		}
		
	}

	switch(state) {
	
		case playerState.idle:
		case playerState.walking:
		case playerState.onhook:
		
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
		case playerState.dead:
		
			horKeypress = 0;
			verKeypress = 0;
			keyJump = 0;
			keyJumpDown = 0;
			keyJumpReleased = 0;
		
		break;
	
	}


	if (horKeypress != 0) {
		
		if ( (state == playerState.offhook) 
		|| ( (isSliding) && (state != playerState.offhook) ) )
			
			hsp = lerp(hsp, clamp(hspAtRelease, spd, hspMax) * horKeypress, .1);
			
		else {
			
			if (!wallJumpTrigger)
				hsp = lerp(hsp, spd * horKeypress, accel);
			//if (slideTime > 0)
				
				//hsp = lerp(hsp, clamp(hspAtRelease, spd, hspMax) * horKeypress, accel * ( (abs(hsp) > spdBase) ? .1 : .25 ) );
		}
		
		facing = horKeypress;
		
		if (abs(frac(hsp)) > .99) 
			hsp = round(hsp);

	} else {
		
		if (state != playerState.offhook) {
			
			if (abs(hsp) > spdBase)
				hsp = lerp(abs(hsp), spdBase - .1, deccel * 0.75) * sign(hsp);
			else
				hsp = lerp(hsp, 0, deccel); 
			
		}
		
		if (abs(hsp) < .05)
			hsp = 0;

	}

	
	if (abs(hsp) > spdBase) 
	&& (isGrounded)
	&& (state == playerState.walking) {
	
		isSliding = true;
	
	}
	
	if (isSliding) {
	
		slideTime++;
		
		if (slideTime >= slideMax) {
		
			isSliding = false;
			slideTime = 0;
		
		}
	
	}
	
	//--------------------------------------------------------------------------------
	// Jumping off semisolids 
	
	if (keyDownPressed) {
	
		if (jumpOffTime == 0)
			jumpOffTime = jumpOffMax;
	
	}
		
	if (jumpOffTime <= 0)
		jumpOffTime = 0;
	else
		jumpOffTime--;
		
	//--------------------------------------------------------------------------------
	
	//grounded bylo tu xd

	
	// Blisko scian nie uzywamy ulamkowych czesci pozycji zeby nie bylo problemow z kolizjami
	
	//if (collision_rectangle(bbox_left - 1, bbox_bottom - 2, bbox_right + 1, bbox_bottom - 1, par_solid, false, false)) x = round(x);
	
	if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_solid, false, false)) y = round(y);
	if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semisolid, true, false)) y = round(y);
	
	if (!isJumping)
		jumpForce = (jumpForceBase * ((abs(hsp * hsp) * .04) + 1));
		
	jumpForce = clamp(jumpForce, 0, (state == playerState.onhook ? 2.8 : 4));

	if ( (isFalling) && (!isJumping) && (coyoteTime == 0) ) || ( (obj_hook.state == hookState.embedded) && (jumpsMax <= 1) ) jumps = 1;

	if (jumps >= jumpsMax) canJump = false;

	if (keyJump) {
		
		if (state == playerState.onhook) {
			
			obj_hook.state = hookState.released;
			
			if (isGrounded) {
				
				doJump();
				//jumps++;
			
			}
			
			/*
			if (vsp > -.5) {
			
				doJump();
				//jumps++;
			
			}
			*/
			
		} else {
			
			if (jumps == jumpsMax) {
			
				// Jezeli wykorzystalismy wszystkie skoki
				
				jumpBuffer = jumpBufferMax;
			
			} else {
			
				if (jumps < jumpsMax) && (!jumpTrigger) && (!isWallSliding) {
				
					doJump();
					jumps++;

					//jumpTrigger = true;
			
				}
			
			}
			
		}
		
	}
	
	if (jumpBuffer > 0) {
		
		jumpBuffer--;
	
		if (jumps < jumpsMax) && (!jumpTrigger) {
			
			if (state == playerState.offhook) && (abs(hsp) < spdBase)
				offHookTrigger = false;

			doJump();
			jumps++;

			//jumpTrigger = true;
			
		}
		
	}
	
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
			
				if (keyJump) && (!jumpTrigger) {
				
					doJump();
			
					jumpTrigger = true;
					
				}
				
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
			vsp *= 0.8;
	
		}
		
	}
	
	//--------------------------------------------------------------------------------
	// Walljump
	
	if (canWalljump) && (!isGrounded) && (allowMovement) {
	
		var toLeft = collision_rectangle(bbox_left - 1, bbox_top, bbox_left + 1, bbox_bottom, obj_walljump_8, false, false);
		var toRight = collision_rectangle(bbox_right - 1, bbox_top, bbox_right + 1, bbox_bottom, obj_walljump_8, false, false);
		
		var wallSlideTreshold = .025;
		var wallSlideSpd = .85;
		//var vspPrev = (isWallSliding ? 0 : vsp);

		if (toLeft) {
		
			isWallSliding = (horKeypress == -1 ? true : false);
			offHookTrigger = false;
		
		} else if (toRight) {
			
			isWallSliding = (horKeypress == 1 ? true : false);
			offHookTrigger = false;
			
		} else {
		
			wallSlideTimer = wallSlideBase;
			isWallSliding = false;
			wallJump = (wallJumpTimer <= 0 ? 0 : wallJump);
		
		}
		
		if (isWallSliding) {
			
			state = playerState.wallslide;
			
			if (isFalling) {
				
				wallSlideTimer = (wallSlideTimer >= 1 ? 1 : wallSlideTimer + wallSlideTreshold);
				
				vsp *= wallSlideSpd * (wallSlideTimer + 1 - wallSlideSpd);
				
				if (keyJump) {
					
					isWallSliding = false;
					wallJumpTrigger = true;
					hsp = -horKeypress * spdBase * 1.2;
					doJump();
					wallJump = horKeypress;
					
				}
			
			}
			
		}
	
	} else {
	
		wallSlideTimer = wallSlideBase;
		isWallSliding = false;
		wallJump = (wallJumpTimer <= 0 ? 0 : wallJump);
	
	}
	
	if (wallJumpTrigger) {
		
		if (wallJumpTimer <= 0) {
		
			wallJumpTimer = wallJumpMax;
			wallJumpTrigger = false;
		
		} else {
			
			wallJumpTimer--;
			
		}
		
	}
	
	hsp = clamp(hsp, -hspMax, hspMax);
	vsp = clamp(vsp, vspMin, vspMax);
	
	
	// Dont check for collisions when dead
	// Also override some variables we dont need
	
	if (state == playerState.dead) {
	
		isFalling = false;
		isGrounded = false;
		isJumping = false;
		isSkidding = false;
		isSliding = false;
		isTurning = false;
		isWallSliding = false;
		inAir = true;
		jumpBuffer = 0;
		coyoteTime = 0;
		jumpTime = 0;
		wallJumpTrigger = false;
		grav = 0;
		accel = 0;
		deccel = 0;
	
		exit;
	
	}
	
	//--------------------------------------------------------------------------------
	// Ledge forgiveness

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
	
	//--------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------
	// Kolizje
	
	if (state != playerState.onhook) {
	
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
				if (abs(hsp) > spdBase) 
					vsp -= 1.4; 
			
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
			
			if (wallJumpTimer < wallJumpMax) wallJumpTimer = 0;
			
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
	
		if (allowMovement)
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
		
		if (allowMovement)
			y += vsp;
	
		//--------------------------------------------------------------------------------
	}

	// Stupid slope fix ???
	if (!isGrounded) && (jumpsMax == 1) jumps = 1;

}