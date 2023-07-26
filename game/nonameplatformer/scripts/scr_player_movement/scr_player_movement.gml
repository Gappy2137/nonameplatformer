function scr_player_movement() {

	var keyDown	 =			keyboard_check(ord("S"));
	var keyLeft	 =			keyboard_check(ord("A"));
	var keyRight =			keyboard_check(ord("D"));
	var keyUp =				keyboard_check(ord("W"));

	var keyJump =			keyboard_check_pressed(vk_space);
	var keyJumpReleased =	keyboard_check_released(vk_space);

	var horKeypress = keyRight - keyLeft;
	//var verKeypress = keyUp - keyDown;

	if (horKeypress != 0) {
		
		hsp = lerp(hsp, spd * horKeypress, accel);

	} else {
		
		hsp = lerp(hsp, 0, deccel);

	}
	
	
	if (collision_rectangle(bbox_left + 1, bbox_bottom, bbox_right - 1, bbox_bottom, par_collision, true, false))
	|| (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom, par_slope, true, false)) {
		
		isGrounded = true;
		inAir = false;
		isJumping = false;
		jumpThreshold = 0;
		canJump = true;
		jumpTime = 0;
			
	
	} else {
	
		isGrounded = false;
		canJump = false;
	
	}
	
	// Blisko scian nie uzywamy ulamkowych czesci pozycji zeby nie bylo problemow z kolizjami
	
	if (collision_rectangle(bbox_left - 1, bbox_bottom - 1, bbox_right + 1, bbox_bottom - 1, par_collision, true, false)) x = round(x);
	
	if (collision_rectangle(bbox_left - 1, bbox_bottom, bbox_right + 1, bbox_bottom + 4, par_collision, true, false)) y = round(y);
	
	
	isFalling = vsp > 0 ? true : false;
	
	
	
	if (keyJump) {
		
		jumpBuffer = jumpBufferMax;
		
	}
	
	if (jumpBuffer > 0) {
		
		jumpBuffer--;
	
		if (canJump) {
			
			vsp = -jumpForce;
			inAir = true;
			isJumping = true;
			isGrounded = false;
			canJump = false;
			
		}
	
	}
	
	
	if (isJumping) jumpTime++;
	
	
	if (keyJumpReleased) {
		
		if (isJumping) && (!isFalling) && (!isGrounded) {
	
			jumpTime = jumpTimeThreshold;
			inAir = true;
			vsp /= 2;
	
		}
		
	}
	
	if (!isGrounded) && ((jumpTime >= jumpTimeThreshold) || (!isJumping)){
	
		inAir = true;
		vsp += grav;
		
	}
	
	hsp = clamp(hsp, -hspMax, hspMax);
	vsp = clamp(vsp, -vspMax, vspMax);
	
	var horCollision = instance_place(x + hsp, y, par_collision);
	
	if (horCollision) 
	&& (object_get_parent(horCollision.object_index) != par_slope)
	&& (object_get_parent(horCollision.object_index) != par_slope_inv) {

		while (!instance_place(x + sign(hsp), y, par_collision)) {
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
	    
		if !instance_place(x + hsp, y + yplus, par_collision) {
			
			y += yplus;

		}
		
	}
	
	if (slopeCollisionHor)
	&& (object_get_parent(slopeCollisionHor.object_index) != par_slope_inv) {
	
		var yplus = 0;
		
		while ( (instance_place(x + hsp, y - yplus, par_slope)) && (yplus <= abs(2*hsp)) )
			yplus += 1;
	    
		if instance_place(x + hsp, y - yplus, par_collision) {
			
			while (!instance_place(x + sign(hsp), y, par_collision)) {
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
	    
		if instance_place(x + hsp, y + yplus, par_collision) {
			
			while (!instance_place(x + sign(hsp), y, par_collision)) {
				x += sign(hsp);
			}
			
			hsp = 0;
			
		} else
		
			y += yplus;
	
	}
	
	x += hsp;
	
	if (isJumping) && (!isFalling) {
		
		if (abs(hsp) < 0.5) {
			
			var bbox_half = (bbox_left + (bbox_right - bbox_left) / 2);
			var wallPassThreshold = 8;
		
			if (collision_rectangle(bbox_half - wallPassThreshold, bbox_top - 1, bbox_half, bbox_top - 1, par_collision, true, false))
			&& (!collision_rectangle(bbox_half, bbox_top - vsp, bbox_half + wallPassThreshold, bbox_top - vsp, par_collision, true, false)) {
	
				x += wallPassThreshold;
	
			}
		
			if (!collision_rectangle(bbox_half - wallPassThreshold, bbox_top - vsp, bbox_half, bbox_top - vsp, par_collision, true, false))
			&& (collision_rectangle(bbox_half, bbox_top - 1, bbox_half + wallPassThreshold, bbox_top - 1, par_collision, true, false)) {
	
				x -= 1;
	
			}
			
		}
		
	}
	
	var verCollision = instance_place(x, y + vsp, par_collision);
	
	if (verCollision) {
		
		while (!instance_place(x, y + sign(vsp), par_collision)) {
			y += sign(vsp);
		}
			
		vsp = 0;
			
	}
	
	y += vsp;
	
	/*
	for(var i = 0; i < 100; ++i;){
				
			if (!instance_place(x + i, y, par_collision)){
					x += i;
					break;
			}
			if (!instance_place(x - i, y, par_collision)){
					x -= i;
					break;
			}
			if (!instance_place(x, y - i, par_collision)){
					x -= i;
					break;
			}
			if (!instance_place(x, y + i, par_collision)){
					x += i;
					break;
			}

	}
	*/
}