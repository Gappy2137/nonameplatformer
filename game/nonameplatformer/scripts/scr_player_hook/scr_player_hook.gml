function scr_player_hook() {
	
	var keyJump =			keyboard_check_pressed(vk_space);
	
	if (obj_hook.state == hookState.embedded) {
	
		var hx = obj_hook.x;
		var hy = obj_hook.y;
	
		var angle = point_direction(x, y, hx, hy);
		var dist = point_distance(x, y, hx, hy);
		
		var hookedSpd = spd * 3;
		
		if (dist < obj_hook.freeRange) {
		
			obj_hook.hookPullEnd = true;
			hookedState = playerHookedState.fall;
		
		} else {
			
			if (!obj_hook.hookPullEnd)
				hookedState = playerHookedState.pull;
			
		}

		if (hookedState == playerHookedState.pull) {
		
			hsp = lengthdir_x(hookedSpd, angle);
			vsp = lengthdir_y(hookedSpd, angle);
		
		} else
		if (hookedState == playerHookedState.fall) {
		
			if (dist > obj_hook.slowDownRange) {
			
				//ignoreGravity = true;
				//hspOnHook = lerp(hspOnHook, hsp, 0.1);
				//vspOnHook = lerp(vspOnHook, vsp, 0.1);
				hsp = lerp(hsp, 0, 0.2);
				vsp = lerp(vsp, 0, 0.2);
			
			}
		
		}
	
		if (keyJump) {
			
			obj_hook.state = hookState.released;
			hookedState = playerHookedState.none;
			
			if (!instance_place(x, y - abs(vsp), par_solid)) {
				
				y--;
				justJumped = true;
				inAir = true;
				isJumping = true;
				isGrounded = false;
				isFalling = false;
				canJump = false;
				
			} else {
			
				vsp = 0;
				y++;
			
			}
			
		}
		
		hspOnHook = clamp(hspOnHook, 0, hsp);
		vspOnHook = clamp(vspOnHook, 0, vsp);

	} else {
	
		ignoreGravity = false;
		hookedState = playerHookedState.none;
	
	}
	
}