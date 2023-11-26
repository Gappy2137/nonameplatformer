function scr_player_draw() {

	// First draw the player
	// Then draw hook's wire
	// And then the hook itself

	// Player

	var realPos = [];

	var cosine = dcos(angle);
	var sine = dsin(angle);

	realPos[0] = [x + ((facing != -1 ? sprPos[0][0] : sprPos[1][0]) * cosine) - (sprPos[0][1] * sine), y + ((facing != -1 ? sprPos[0][0] : sprPos[1][0]) * sine) + (sprPos[0][1] * cosine)];
	realPos[1] = [x + ((facing != -1 ? sprPos[1][0] : sprPos[0][0]) * cosine) - (sprPos[1][1] * sine), y + ((facing != -1 ? sprPos[1][0] : sprPos[0][0]) * sine) + (sprPos[1][1] * cosine)];
	realPos[2] = [x + ((facing != -1 ? sprPos[2][0] : sprPos[3][0]) * cosine) - (sprPos[2][1] * sine), y + ((facing != -1 ? sprPos[2][0] : sprPos[3][0]) * sine) + (sprPos[2][1] * cosine)];
	realPos[3] = [x + ((facing != -1 ? sprPos[3][0] : sprPos[2][0]) * cosine) - (sprPos[3][1] * sine), y + ((facing != -1 ? sprPos[3][0] : sprPos[2][0]) * sine) + (sprPos[3][1] * cosine)];


	switch (obj_inventory.equipped) {
	
		case weaponEnum.none:
		
			draw_sprite_pos(spriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);
												  
		break;
		
		case weaponEnum.hook:
		
			draw_sprite_pos(bodySpriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);
												  
			draw_sprite_pos(headSpriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);												  

		break;
		
		case weaponEnum.pistol:
		
			draw_sprite_pos(bodySpriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);
												  
			draw_sprite_pos(headSpriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);	
		
		break;
	}

	// Hook's wire
	
	if (obj_inventory.equipped == weaponEnum.hook) {

		if (obj_hook.ropeDrawTimer != 0) && (obj_hook.state != hookState.onPlayer) {
	
			draw_set_color(obj_hook.wireColor);
			draw_line_width(weaponEndX, weaponEndY, obj_hook.drawX, obj_hook.drawY - 1, 1);

		}

	}

	// Hook

	switch (obj_inventory.equipped) {
	
		case weaponEnum.hook:
		
			draw_sprite_ext(weaponSpriteInd, weaponFrame, x + weaponOX + (facing ? 0 : 4), y + weaponOY, facing, 1, (facing ? weaponAngle : weaponAngle - 180), #FFFFFF, 1);
		
		break;
		
	}

}