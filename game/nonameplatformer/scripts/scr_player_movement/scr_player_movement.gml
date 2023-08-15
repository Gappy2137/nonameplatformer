function scr_player_movement() {

	var keyDown	 =			keyboard_check(ord("S"));
	var keyLeft	 =			keyboard_check(ord("A"));
	var keyRight =			keyboard_check(ord("D"));
	var keyUp =				keyboard_check(ord("W"));
	
	var keyDownPressed =	keyboard_check_pressed(ord("S"));

	var keyJump =			keyboard_check_pressed(vk_space);
	var keyJumpReleased =	keyboard_check_released(vk_space);
	var keyJumpDown =		keyboard_check(vk_space);

	var horKeypress = keyRight - keyLeft;
	//var verKeypress = keyUp - keyDown;

	if (horKeypress != 0) {
		
		
		if (isSkidding) {
			spd = spdBase / 1.25;
			accel = 0.2;
		} else {
			spd = spdBase;
			accel = 0.4;
		}
		
		
		hsp = lerp(hsp, spd * horKeypress, accel);
		facing = horKeypress;
		

	} else {
		
		if (abs(hsp) > spd / 2) 
			hsp = lerp(hsp, 0, deccel / 2);
		else
			hsp = lerp(hsp, 0, deccel * 2);

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
	
	if ( (instance_place(x, y + 1, par_solid))
	|| (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_slope, true, false)) )
	|| ( (vsp >= 0) && (semisolidCollision) && (bbox_bottom <= semisolidCollision.bbox_top) && (jumpOffTime == 0) ) {
		
		isGrounded = true;
		inAir = false;
		jumpThreshold = 0;
		canJump = true;
		jumpTime = 0;
		isJumping = false;
		
	} else {
		
		isGrounded = false;
		canJump = false;
		
	}
	
	if (isGrounded) 
		coyoteTime = coyoteMax;
	
	// Blisko scian nie uzywamy ulamkowych czesci pozycji zeby nie bylo problemow z kolizjami
	
	if (collision_rectangle(bbox_left - 1, bbox_bottom - 2, bbox_right + 1, bbox_bottom - 1, par_solid, false, false)) x = round(x);
	
	if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 4, par_solid, false, false)) y = round(y);
	if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, par_semisolid, true, false)) y = round(y);
	
	isFalling = vsp > 0 ? true : false;
	
	if (!isJumping)
		jumpForce = jumpForceBase * ((abs(hsp * hsp) / 25) + 1);

	if (keyJump)
		jumpBuffer = jumpBufferMax;
	
	if (jumpBuffer > 0) {
		
		jumpBuffer--;
	
		if (canJump) {
			
			y--;
			justJumped = true;
			inAir = true;
			isJumping = true;
			isGrounded = false;
			isFalling = false;
			canJump = false;
			
		}
	
	}
	
	if (isJumping) jumpTime++;
	
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
			
				if (keyJump) {
					
					y--;
					justJumped = true;
					inAir = true;
					isJumping = true;
					isGrounded = false;
					isFalling = false;
					canJump = false;
				
				}
				
			}
		
		}
		
		if (!isFalling) {
			
			if (!isGrounded) {
				
				if (abs(vsp) < 0.75) {
			
					grav = lerp(grav, gravBase / 4, 0.1);
			
				} else {
			
					grav = gravBase;
			
				}
				
			} else {
			
				grav = 0;
			
			}
			
		} else {
		
			grav = gravBase * 1.75;
		
		}

	}
	
	if (justJumped) {
	
		jumpAccelTime--;
		
		if (jumpAccelTime <= 0) {
			
			jumpAccelTime = jumpAccelThreshold;
			justJumped = false;
		
		}
		
		vsp = lerp(vsp, -jumpForce, jumpAccel);
	
	}
	
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
	
	// Ledge forgiveness
	
	if (isFalling) {
	
		if (hsp != 0) {
			
			var threshold = 4;
		
			var ledgeCol = collision_rectangle(bbox_left + hsp, bbox_bottom - threshold, bbox_right + hsp, bbox_bottom, par_solid, false, false);
			
			if (ledgeCol)
			&& (object_get_parent(ledgeCol.object_index) != par_slope) { 
			
				var _height = (bbox_bottom - bbox_top);
				var emptyCol = collision_rectangle(bbox_left + hsp, bbox_top - threshold, bbox_right + hsp, bbox_bottom - threshold, par_solid, false, false);
			
				if (!emptyCol) {
					
					x += sign(hsp);
					y = ledgeCol.bbox_top - sprite_yoffset;
					
				}
			
			}
		
		}
	
	}
	
	var horCollision = instance_place(x + hsp, y, par_solid);
	
	if (horCollision) 
	&& (object_get_parent(horCollision.object_index) != par_slope)
	&& (object_get_parent(horCollision.object_index) != par_slope_inv)
	&& (object_get_parent(horCollision.object_index) != par_semisolid){

		while (!instance_place(x + sign(hsp), y, par_solid)) {
			x += sign(hsp);
		}
			
		hsp = 0;
			
	}
	
	var slopeCollisionHor = instance_place(x + hsp, y, par_slope);
	var slopeCollisionHorInv = instance_place(x + hsp, y, par_slope_inv);
	
	if (instance_place(x, y + 1, par_slope))
	&& (!instance_place(x + hsp, y + 1, par_slope)) {
		
		var yplus = 0;
		
		while ( (!instance_place(x + round(hsp), y + yplus + 1, par_slope)) && (yplus <= abs(2*round(hsp))) )
			yplus++;
	    
		if !instance_place(x + hsp, y + yplus, par_solid) {
			
			y += yplus;

		}
		
	}
	
	if (slopeCollisionHor)
	&& (object_get_parent(slopeCollisionHor.object_index) != par_slope_inv) {
	
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
			slopeup++;
			
		}
	
	}
	
	if (slopeCollisionHorInv)
	&& (object_get_parent(slopeCollisionHorInv.object_index) != par_slope) {
	
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
		a=topThreshold;
		b=topThresholdBlock;

		if (hsp <= 1) {
			
			var blockCol = collision_rectangle(bbox_left - wallPassThreshold, bbox_top - topThreshold, bbox_right - wallPassThreshold, bbox_bottom, par_solid, true, false);
			
			if (!blockCol) {
				
				var emptyCol = (collision_rectangle(bbox_left + wallPassThreshold, bbox_top - topThreshold, bbox_right + 1, bbox_bottom, par_solid, true, false));
				
				if (emptyCol)
				&& (object_get_parent(emptyCol.object_index) != par_semisolid)
				&& (object_get_parent(emptyCol.object_index) != par_slope)
				&& (object_get_parent(emptyCol.object_index) != par_slope_inv)
				
					x -= bbox_right - emptyCol.bbox_left;
	
			}
			
		}
		
		if (hsp >= -1) {
			
			var blockCol = collision_rectangle(bbox_left + wallPassThreshold, bbox_top - topThreshold, bbox_right + wallPassThreshold, bbox_bottom, par_solid, true, false);
			
			if (!blockCol) {
				
				var emptyCol = (collision_rectangle(bbox_left - 1, bbox_top - topThreshold, bbox_right - wallPassThreshold, bbox_bottom, par_solid, true, false));
				
				if (emptyCol) 
				&& (object_get_parent(emptyCol.object_index) != par_semisolid)
				&& (object_get_parent(emptyCol.object_index) != par_slope)
				&& (object_get_parent(emptyCol.object_index) != par_slope_inv)
				
					x += emptyCol.bbox_right - bbox_left;
	
			}
			
		}
		
	}
	
	if (vsp > 0) && (jumpOffTime == 0) {
		
		if collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + (vsp), par_semisolid, true, false) if (vsp > 1) vsp = 1;
		
		if (collision_rectangle(bbox_left, bbox_bottom - 2.5, bbox_right, bbox_bottom, par_semisolid, true, false)) {
			y--;
			vsp = 0;
		}
		
		if (semisolidCollision) 
		&& (bbox_bottom <= semisolidCollision.bbox_top)
		{
			
			if (semisolidCollision.semiSolid) {
			
				vsp = 0;
				
			}
	
		}
	
	}

	
	var verCollision = instance_place(x, y + vsp, par_solid);
	
	if (verCollision) {
		
		if ((object_get_parent(verCollision.object_index) != par_semisolid)) {
			
			while (!instance_place(x, y + sign(vsp), par_solid)) {
				y += sign(vsp);
			}
			
			vsp = 0;
			
		}
			
	}
	
	y += vsp;

}