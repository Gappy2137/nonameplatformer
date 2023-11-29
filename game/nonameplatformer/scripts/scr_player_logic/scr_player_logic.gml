function scr_player_logic() {
	
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

}