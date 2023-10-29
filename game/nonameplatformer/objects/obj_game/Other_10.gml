if (!instance_exists(obj_player)) {

	//[0] = hsp;
	//[1] = vsp;
	//[2] = state;
	//[3] = facing;
	//[4] = bbox_left;
	//[5] = bbox_bottom;
	//[6] = rmTrans.bbox_left;
	//[7] = rmTrans.bbox_bottom;
	
	var ar = roomTransPlayerVars;
	
	var relX = (ar[4] - ar[6]);
	var relY = (ar[7] - ar[5]);
	
	instance_create_layer(roomToX - 4 + (transOrientation == roomTrans.up || transOrientation == roomTrans.down ? relX : 0),
						 (roomToY + 4) - (transOrientation == roomTrans.right || transOrientation == roomTrans.left ? relY : 0),
						 LAYER_INST, obj_player);
	
	with (obj_player) {

		hsp = ar[0];
		vsp = ar[1];
		state = ar[2];
		facing = ar[3];
	
	}

	
} else {
	
	with (obj_camera) {
		
		following = obj_player;
		camX = obj_player.x;
		camY = obj_player.y;
		setupTimer = 0;
		
	}
	
}