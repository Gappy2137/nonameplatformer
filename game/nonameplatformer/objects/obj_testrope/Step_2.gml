
if (lastPiece) {

	if (setupTimer <= 0) {
		
		setupTimer = 0;
		
		phy_rotation = 0;
		phy_fixed_rotation = true;
	
		obj_player.x = phy_position_x + 1;
		obj_player.y = phy_position_y - 3;
	
		obj_player.hsp = phy_speed_x;
		obj_player.vsp = phy_speed_y;
		
	} else {
		
		setupTimer--;
		
		phy_position_x = obj_player.x;
		phy_position_y = obj_player.y + 3;

	}

}