function scr_player_logic() {

	if (x < -16) || (x > room_width + 16) || (y < -16) || (y > room_height + 16)
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
	
	if (obj_game.roomTransition) {
	
		allowMovement = false;
	
	} else {
	
		allowMovement = true;
	
	}

}