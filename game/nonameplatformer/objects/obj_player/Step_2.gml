if (obj_inventory.equipped != weaponEnum.none) {
	
	if (state != playerState.wallslide) {
		if (weaponAngle < 270) && (weaponAngle > 90)
			facing = -1;
		else
			facing = 1;
	}
		
	if (obj_hook.state == hookState.onPlayer)
		weaponAngle = point_direction(x + weaponOX + (facing ? 0 : 4), y + weaponOY, mouse_x, mouse_y);
	else {
		
		var xx = mouse_x;
		var yy = mouse_y;
		
		if (instance_exists(obj_rope_anchor)) {
			
			xx = obj_rope_anchor.anchorX;
			yy = obj_rope_anchor.anchorY;
			
		}
			
		weaponAngle = point_direction(x + weaponOX + (facing ? 0 : 4), y + weaponOY, xx, yy);
		
	}
			
	weaponEndX = x + weaponOX + lengthdir_x(5, weaponAngle) + (facing ? 0 : 4);
	weaponEndY = y + weaponOY - 1 + lengthdir_y(5, weaponAngle);
	
}

if (!landingAnim)
	landed = false;

justLanded = false;