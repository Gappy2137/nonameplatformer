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
	
	}
	
	var rmArea = instance_place(x, y, obj_cameraborder_8);
	
	area = (rmArea ? rmArea.num : 0)

}