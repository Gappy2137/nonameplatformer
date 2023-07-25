function scr_player_movement() {

	var keyDown	 =		keyboard_check(ord("S"));
	var keyLeft	 =		keyboard_check(ord("A"));
	var keyRight =		keyboard_check(ord("D"));
	var keyUp =			keyboard_check(ord("W"));

	var keyJump =		keyboard_check(vk_space);

	var horKeypress = keyRight - keyLeft;
	//var verKeypress = keyUp - keyDown;

	if (horKeypress != 0) {
		
		hsp = lerp(hsp, spd * horKeypress, accel);

	} else {
		
		hsp = lerp(hsp, 0, deccel);

	}
	
	if (collision_rectangle(bbox_left + 1, bbox_bottom, bbox_right - 1, bbox_bottom, par_collision, true, false))
	|| (collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom, par_slope, true, false)){
		
		isGrounded = true;
		inAir = false;
		isJumping = false;
	
	} else {
	
		isGrounded = false;
	
	}
	
	if (keyJump) {
		
		if (!isJumping) && (isGrounded) {
			vsp = -jumpForce;
			inAir = true;
			isJumping = true;
			isGrounded = false;
		}
		
	}
	
	if (!isGrounded) {

		inAir = true;
		vsp += grav;
	
	}

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
	var slopeCollisionDown = instance_place(x, y + vsp, par_slope);
	
	if (slopeCollisionHor)
	&& (object_get_parent(slopeCollisionHor.object_index) != par_slope_inv) {
	
		var yplus = 0;
		var _solid = par_slope;
		
		while ( (instance_place(x + hsp, y - yplus, _solid)) && (yplus <= abs(2*hsp)) )
			yplus += 1;
	    
		if instance_place(x + hsp, y - yplus, _solid) {
			
			while (!instance_place(x + sign(hsp), y, par_collision)) {
				x += sign(hsp);
			}
			
			hsp = 0;
			
		} else
		
			y -= yplus;
	
	}
	
	if (slopeCollisionHorInv)
	&& (object_get_parent(slopeCollisionHorInv.object_index) != par_slope) {
	
		var yplus = 0;
		var _solid = par_slope_inv;
		
		while ( (instance_place(x + hsp, y + yplus, _solid)) && (yplus <= abs(2*hsp)) )
			yplus += 1;
	    
		if instance_place(x + hsp, y + yplus, par_collision) {
			
			while (!instance_place(x + sign(hsp), y, par_collision)) {
				x += sign(hsp);
			}
			
			hsp = 0;
			
		} else
		
			y += yplus;
	
	}
	
	if (slopeCollisionDown)
	&& (object_get_parent(slopeCollisionDown.object_index) != par_slope_inv) {
		
		var yplus = 0;
		var _solid = par_slope;
		
		while ( (instance_place(x + hsp, y + yplus, _solid)) && (yplus <= abs(2*hsp)) )
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
	
	var verCollision = instance_place(x, y + vsp, par_collision);
	
	if (verCollision) {
		
		while (!instance_place(x, y + sign(vsp), par_collision)) {
			y += sign(vsp);
		}
			
		vsp = 0;
			
	}
	
	y += vsp;
	
	for(var i = 0; i < 10; ++i;){
				
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
	
}