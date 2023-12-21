event_inherited();

sprPos[0] = [-sprOffset, -sprOffset];
sprPos[1] = [+sprOffset, -sprOffset];
sprPos[2] = [+sprOffset, +sprOffset];
sprPos[3] = [-sprOffset, +sprOffset];

#region Process logic
	
	var hazard = instance_place(x, y, obj_hazard_8);

	if ((x < -16) || (x > room_width + 16) || (y < -16) || (y > room_height + 16)) || (hazard)
		if (state != playerState.dead)
			doDie();
	
	var rmTrans = instance_place(x, y, obj_roomtrans_8);
	
	if (rmTrans) {
	
		obj_game.roomTransition = true;
		obj_game.transOrientation = rmTrans.orient;
		obj_game.roomToX = rmTrans.toX;
		obj_game.roomToY = rmTrans.toY;
		obj_game.nextRoom = rmTrans.nextRoom;
		
		var i = 0;
		
		obj_game.roomTransPlayerVars[i++] = hsp;
		obj_game.roomTransPlayerVars[i++] = vsp;
		obj_game.roomTransPlayerVars[i++] = state;
		obj_game.roomTransPlayerVars[i++] = facing;
		obj_game.roomTransPlayerVars[i++] = bbox_left;
		obj_game.roomTransPlayerVars[i++] = bbox_bottom;
		obj_game.roomTransPlayerVars[i++] = rmTrans.bbox_left;
		obj_game.roomTransPlayerVars[i++] = rmTrans.bbox_bottom;
		
		
	
	}
	
	var rmArea = instance_place(x, y, obj_cameraborder_8);
	
	area = (rmArea ? rmArea.area : 0);
	
	if (obj_game.roomTransition) || (state == playerState.dead) {
	
		allowMovement = false;
	
	} else {
	
		allowMovement = true;
	
	}
	
	if (state == playerState.dead) {
		
		jumpsMax = 1;
		jumps = 0;
		
		if (deadTimer < 1) {
			obj_hook.state = hookState.released;
		}
		
		if (deadTimer > deadMax * .5) {
			
			var resp = [];
			var px = 0, py = 0;
		
			var i = 0;
			repeat(instance_number(obj_player_respawn)) {
				
				resp[i] = instance_find(obj_player_respawn, i);
				
				if (resp[i].area == area) {
				
					px = resp[i].x;
					py = resp[i].y - 16;
					break;
				
				}
				
				i++;
				
			}
			
			x = lerp(x, px, 0.25);
			y = lerp(y, py, 0.25);
			
			if (collision_circle(x, y, 2, resp[i], false, false))
				deadTimer = deadMax;
			
		} else {
		
			hsp = lerp(hsp, 0, 0.1);
			x += hsp;
			vsp = lerp(vsp, 0, 0.1);
			y += vsp;
		
		}
	
		if (deadTimer >= deadMax) {
			
			deadTimer = 0;
			state = playerState.idle;
			
		} else {
		
			deadTimer++;
		
		}
	
	}
	
	// Extra jump orb
	
	var jumpOrb = instance_place(x, y, obj_jump_orb);
	
	if (jumpOrb) && (allowMovement) {
		
		if (!jumpOrb.collected) {
			
			jumpOrb.collected = true;
			jumpOrb.animFrame = 1;
			with (jumpOrb) event_user(0);
			jumpsMax = 2;
			if (state == playerState.onhook)
				jumps = 1;
			
		}
	
	}

#endregion

#region Process movement

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

#endregion

#region Process animations


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
			bodySpriteInd = bodySprite[playerSprite.idle];
			if (weaponAngle > 60) && (weaponAngle < 120)
				headSpriteInd = headSprite[playerSprite.lookup];
			else
				headSpriteInd = headSprite[playerSprite.idle];

			weaponSpriteInd = weaponSprite[obj_inventory.equipped];
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
				bodySpriteInd = bodySprite[playerSprite.idle];
				headSpriteInd = headSprite[playerSprite.idle];
				weaponSpriteInd = weaponSprite[obj_inventory.equipped];
				animFrameNum = 1;
				animSpeed = 0;
				animFrame = 2;
				
			} else {
			
				if (isJumping) {
					
					spriteInd = jumpSprite;
					bodySpriteInd = bodySprite[playerSprite.jump];
					headSpriteInd = headSprite[playerSprite.jump];
					weaponSpriteInd = weaponSprite[obj_inventory.equipped];
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
						bodySpriteInd = bodySprite[playerSprite.jump];
						headSpriteInd = headSprite[playerSprite.jump];
						weaponSpriteInd = weaponSprite[obj_inventory.equipped];
						animFrameNum = 1;
						animSpeed = 0;
						animFrame = 2;
						
					} else {
						
						if (vsp == 0) {
						
							spriteInd = runSprite;
							bodySpriteInd = bodySprite[playerSprite.run];
							headSpriteInd = headSprite[playerSprite.run];
							weaponSpriteInd = weaponSprite[obj_inventory.equipped];
							animFrameNum = 6;
							animSpeed = abs(hsp / 10);
						
							animFrame += animSpeed;
							if (animFrame >= animFrameNum) {
								animFrame = frac(animFrame);
							}
						
						} else {
						
							spriteInd = jumpSprite;
							bodySpriteInd = bodySprite[playerSprite.jump];
							headSpriteInd = headSprite[playerSprite.jump];
							weaponSpriteInd = weaponSprite[obj_inventory.equipped];
							animFrameNum = 1;
							animSpeed = 0;
							animFrame = 2;
						
						}
						
					}
				
				}
			
			}
			

		
		break;
		case playerState.onhook:
		
			if (isGrounded) {
				
				spriteInd = runSprite;
				bodySpriteInd = bodySprite[playerSprite.run];
				headSpriteInd = headSprite[playerSprite.run];
				weaponSpriteInd = weaponSprite[obj_inventory.equipped];
				animFrameNum = 6;
				animSpeed = abs(hsp / 10);
						
				animFrame += animSpeed;
				if (animFrame >= animFrameNum) {
					animFrame = frac(animFrame);
				}
				
			} else {
			
				spriteInd = jumpSprite;
				bodySpriteInd = bodySprite[playerSprite.jump];
				if (weaponAngle > 60) && (weaponAngle < 120) {
					
					headSpriteInd = headSprite[playerSprite.lookup];
					animFrame = 0;
					
				} else {
					
					headSpriteInd = headSprite[playerSprite.jump];
					animFrame = 2;
					
				}
					
				weaponSpriteInd = weaponSprite[obj_inventory.equipped];
				animFrameNum = 1;
				animSpeed = 0;
			
			}
		
		break;
		case playerState.offhook:
		
			spriteInd = jumpSprite;
			bodySpriteInd = bodySprite[playerSprite.jump];
			headSpriteInd = headSprite[playerSprite.jump];
			weaponSpriteInd = weaponSprite[obj_inventory.equipped];
			animFrameNum = 1;
			animSpeed = 0;
			animFrame = 2;
		
		break;
		case playerState.wallslide:
		
			spriteInd = wallslideSprite;
			bodySpriteInd = wallslideSprite;
			headSpriteInd = spr_none;
			weaponSpriteInd = spr_none;
			animFrameNum = 1;
			animSpeed = 0;
		
		break;
		case playerState.dead:
		
			spriteInd = deadSprite;
			bodySpriteInd = deadSprite;
			headSpriteInd = spr_none;
			weaponSpriteInd = spr_none;
			animFrameNum = 1;
			animSpeed = 0;
		
		break;
	}
	
	// Weapon Anim
	
	if (obj_inventory.equipped == weaponEnum.hook)
		weaponFrame = (obj_hook.state == hookState.onPlayer ? 0 : 1);
	
	// Juice

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
			landingAnim = false;
			
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

	if (state == playerState.dead) resetJuice();

#endregion

// FX
if (landed) && (justLanded) {
	
	if (instance_place(x, y, obj_dustpart_8)) {
		
		newParticle(x, y + sprite_yoffset, spr_dust_part, #885041, 3, 0);

	}
	
	//justLanded = false;

}

if keyboard_check(ord("J")) v-=.1;
if keyboard_check(ord("K")) v+=.1;

