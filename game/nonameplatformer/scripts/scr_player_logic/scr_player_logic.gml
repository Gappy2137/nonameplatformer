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
		
		obj_game.roomTransPlayerVars[0] = hsp;
		obj_game.roomTransPlayerVars[1] = vsp;
		obj_game.roomTransPlayerVars[2] = state;
		obj_game.roomTransPlayerVars[3] = facing;
		obj_game.roomTransPlayerVars[4] = bbox_left;
		obj_game.roomTransPlayerVars[5] = bbox_bottom;
		obj_game.roomTransPlayerVars[6] = rmTrans.bbox_left;
		obj_game.roomTransPlayerVars[7] = rmTrans.bbox_bottom;
		
		
	
	}
	
	var rmArea = instance_place(x, y, obj_cameraborder_8);
	
	area = (rmArea ? rmArea.num : 0);
	
	if (obj_game.roomTransition) || (state == playerState.dead) {
	
		allowMovement = false;
	
	} else {
	
		allowMovement = true;
	
	}
	
	if (state == playerState.dead) {
		
		if (deadTimer > deadMax * .5) {
			
			var resp = [];
			var px = 0, py = 0;
		
			var i = 0;
			repeat(instance_number(obj_player_respawn)) {
				
				resp[i] = instance_find(obj_player_respawn, i);
				
				if (resp[i].area == area) {
				
					px = resp[i].x;
					py = resp[i].y;
					break;
				
				}
				
				i++;
				
			}
			
		
			hsp = lerp(lengthdir_x(hsp, point_direction(x, y, px, py)), 0, 0.1);
			x += hsp;
			vsp = lerp(lengthdir_y(hsp, point_direction(x, y, px, py)), 0, 0.1);
			y += vsp;
			
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

}