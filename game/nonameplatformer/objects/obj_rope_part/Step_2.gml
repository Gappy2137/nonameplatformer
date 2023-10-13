
if (lastPiece) {

	if (setupTimer <= 0) {
		
		setupTimer = 0;
		
		phy_rotation = 0;
		phy_fixed_rotation = true;
				
		//var hookedSpd = 5;
		//var angle = point_direction(x, y, obj_hook.x, obj_hook.y); 
		
		if (keyboard_check(ord("A")))
			phy_speed_x -= .1;
		if (keyboard_check(ord("D")))
			phy_speed_x += .1;
		
		//phy_speed_x = lengthdir_x(hookedSpd, angle);
		//phy_speed_y = lengthdir_y(hookedSpd, angle);
	
		obj_player.x = round_to_2(phy_position_x + 1);
		obj_player.y = round_to_2(phy_position_y - 3);
			
		obj_player.hsp = phy_speed_x;
		obj_player.vsp = phy_speed_y;
	
		/*
		if (!obj_player.isGrounded) {
			
			obj_player.x = round_to_2(phy_position_x + 1);
			obj_player.y = round_to_2(phy_position_y - 3);
			
			obj_player.hsp = phy_speed_x;
			obj_player.vsp = phy_speed_y;
		
		} else {
		
			phy_position_x = obj_player.x - 1;
			phy_position_y = obj_player.y + 3;
		
		}
		*/

		

		
		
	} else {
		
		setupTimer--;
		
		phy_position_x = obj_player.x;
		phy_position_y = obj_player.y + 3;

	}

}