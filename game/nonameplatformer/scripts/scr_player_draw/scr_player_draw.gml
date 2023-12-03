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

	var doubleJumpAuraCheck = ( (jumpsMax > 1) && (jumps != jumpsMax) && (state != playerState.dead) );

	switch (obj_inventory.equipped) {
	
		case weaponEnum.none:
		
			if (doubleJumpAuraCheck) {
			
				shader_set(sh_outline);
				var tex = sprite_get_texture(spriteInd, animFrame);
				var texWidth = texture_get_texel_width(tex);
				var texHeight = texture_get_texel_height(tex);
				
				shader_set_uniform_f(uTexel, texWidth, texHeight);
				shader_set_uniform_f(uColor, 0.475, 0.392, 0.729, 1.0);
				shader_set_uniform_f(uThickness, 2.0);
			
			}
		
			draw_sprite_pos(spriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1); 
												  
			if (doubleJumpAuraCheck) {
			
				shader_reset();
			
			}
												  
		break;
		
		case weaponEnum.hook:
		
			if (doubleJumpAuraCheck) {
			
				shader_set(sh_outline);
				var tex = sprite_get_texture(spriteInd, animFrame);
				var texWidth = texture_get_texel_width(tex);
				var texHeight = texture_get_texel_height(tex);
				
				shader_set_uniform_f(uTexel, texWidth, texHeight);
				shader_set_uniform_f(uColor, 0.475, 0.392, 0.729, 1.0);
				shader_set_uniform_f(uThickness, 2.0);
			
			}
		
			draw_sprite_pos(headSpriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);		
		
			draw_sprite_pos(bodySpriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
												  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
												  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
												  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
												  1);
													 
			if (doubleJumpAuraCheck) {
			
				shader_reset();
			
			}

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

	// Hook's wire and anchor
	
	if (obj_inventory.equipped == weaponEnum.hook) {
		
		// Wire launching or releasing

		if (obj_hook.ropeDrawTimer != 0) && (obj_hook.state != hookState.onPlayer) {
			
			draw_set_color(obj_hook.wireColor);
			draw_line_width(weaponEndX, weaponEndY, obj_hook.drawX, obj_hook.drawY - 1, 1);

		}
		
		// Wire embedded
		
		if (instance_exists(obj_rope_anchor)) {
		
			if (obj_rope_anchor.setupTimer == 0) {
				
				var p0 = [obj_rope_anchor.phy_position_x, obj_rope_anchor.phy_position_y];
				var p1 = [obj_rope_anchor.bezierX1,obj_rope_anchor.bezierY1];
				var p2 = [obj_rope_anchor.bezierX2,obj_rope_anchor.bezierY2];
				var p3 = [weaponEndX, weaponEndY];

				var q0 = bezier_points(0, p0, p1, p2, p3);

				var seg = 10;
				var i = 1;

				repeat(seg) {
					var t = i / seg;
					var q1 = bezier_points(t, p0, p1, p2, p3);
					draw_set_color(obj_hook.wireColor);
					draw_line_width(q0[0], q0[1], q1[0], q1[1], 1);
					draw_set_color(#FFFFFF);
					q0=q1;
					i++;
				}
				
			}
		
		}
		
		// Anchor

		if (obj_hook.state != hookState.onPlayer) {
		
			draw_sprite_ext(spr_hook, 0, obj_hook.drawX, obj_hook.drawY, 1, 1, (obj_hook.state == hookState.embedded ? point_direction(x, y, obj_hook.anchorX, obj_hook.anchorY) : obj_hook.hookAngle), #FFFFFF, 1);
		
		}

	}

	// Hook Launcher

	switch (obj_inventory.equipped) {
	
		case weaponEnum.hook:
		
			draw_sprite_ext(weaponSpriteInd, weaponFrame, x + weaponOX + (facing ? 0 : 4), y + weaponOY, facing, 1, (facing ? weaponAngle : weaponAngle - 180), #FFFFFF, 1);
		
		break;
		
	}

}