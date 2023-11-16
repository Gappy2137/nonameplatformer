function scr_player_draw() {

	var realPos = [];

	var cosine = dcos(angle);
	var sine = dsin(angle);

	realPos[0] = [x + ((facing != -1 ? sprPos[0][0] : sprPos[1][0]) * cosine) - (sprPos[0][1] * sine), y + ((facing != -1 ? sprPos[0][0] : sprPos[1][0]) * sine) + (sprPos[0][1] * cosine)];
	realPos[1] = [x + ((facing != -1 ? sprPos[1][0] : sprPos[0][0]) * cosine) - (sprPos[1][1] * sine), y + ((facing != -1 ? sprPos[1][0] : sprPos[0][0]) * sine) + (sprPos[1][1] * cosine)];
	realPos[2] = [x + ((facing != -1 ? sprPos[2][0] : sprPos[3][0]) * cosine) - (sprPos[2][1] * sine), y + ((facing != -1 ? sprPos[2][0] : sprPos[3][0]) * sine) + (sprPos[2][1] * cosine)];
	realPos[3] = [x + ((facing != -1 ? sprPos[3][0] : sprPos[2][0]) * cosine) - (sprPos[3][1] * sine), y + ((facing != -1 ? sprPos[3][0] : sprPos[2][0]) * sine) + (sprPos[3][1] * cosine)];


	switch (obj_inventory.equipped) {
	
		#region None
		case weaponEnum.none:
		
			draw_sprite_pos(spriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);
												  
		break;
		#endregion
		
		#region Equipable
		case weaponEnum.hook:
		case weaponEnum.pistol:
		
			
		
		break;
		#endregion
		
		case weaponEnum.hook:
		
		break;
	}

}