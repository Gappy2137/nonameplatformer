
var finalAngle = clamp(windAngle + colAngle + hitAngle, -45, 45);
	
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, finalAngle, #FFFFFF, 1);


