
var grassCol = instance_place(x, y, par_grass);

if (grassCol) {

	with (grassCol) {
	
		var left = collision_rectangle(bbox_left, bbox_top, bbox_right - (sprite_width/2), bbox_bottom, other, false, true);
		var right = collision_rectangle(bbox_left + (sprite_width/2), bbox_top, bbox_right, bbox_bottom, other, false, true);
	
		if (left){
			colAngle = approach(colAngle, -25, colAngleSpd);	
		}else if (right){
			colAngle = approach(colAngle, 25, colAngleSpd);
		}else{
			colAngle = approach(colAngle, 0, colAngleSpd);	
		}
		
		resetColAngle = false;
	
	}
}
