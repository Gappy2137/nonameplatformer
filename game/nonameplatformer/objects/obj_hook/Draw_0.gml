if (state == hookState.embedded)
	if (ropeDrawTimer <= 0) ropeDrawTimer = 0; else ropeDrawTimer--;
else
	ropeDrawTimer = 3;
/*
draw_set_color(#FF0000);
draw_set_alpha(0.2);
draw_circle(x, y, freeRange, false);
draw_set_color(#FFFF00);
draw_set_alpha(0.15);
draw_circle(x, y, slowDownRange, false);
draw_set_color(#00FF00);
draw_set_alpha(0.1);
draw_circle(x, y, maxRange, false);
draw_set_color(#FFFFFF);
draw_set_alpha(1);
*/
if (ropeDrawTimer != 0){
draw_set_color(#FFFFFF);
draw_line_width(chainFromX, chainFromY, drawX, drawY, 1);
}
var a = raycast(x,y,x+lengthdir_x(maxRange, angleToMouse), y+lengthdir_y(maxRange, angleToMouse), par_collision);
if a[0] != noone
draw_line(x,y,a[1], a[2]);

/*
if (state != hookState.onPlayer) {

	var size = 8;

	var fromX = chainFromX;
	var fromY = chainFromY;
	var toX = drawX;
	var toY = drawY;
	
	var chainAngle = point_direction(fromX, fromY, toX, toY);
	
	var dist = point_distance(fromX, fromY, toX, toY);
	
	var parts = ceil(dist / size) + 1;
	
	if (state != hookState.embedded)
	&& (state != hookState.released)
		chainAngle = hookAngle;
	
	var i = 0;
	
	var offset = 4;

	var originX = -(dcos(chainAngle) * offset) - (dcos(chainAngle - 90) * offset);
	var originY = -(-dsin(chainAngle) * offset) - (-dsin(chainAngle - 90) * offset);
	
	repeat(parts) {
		
		var partWidth = (i == parts - 1 ? size * frac(dist / size) : size)
		
		draw_sprite_general(spr_hook_chain, 1, 0, 0, partWidth, size, chainFromX + originX - (-i * size * dcos(chainAngle)), chainFromY + originY + (-i * size * dsin(chainAngle)), 1, 1, chainAngle, #FFFFFF, #FFFFFF, #FFFFFF, #FFFFFF, 1);
		
		i++;
		
	}

}

var realDrawX = drawX, realDrawY = drawY;

if (state != hookState.embedded) && (state != hookState.released){
	var _dist = point_distance(chainFromX, chainFromY, drawX, drawY);

	realDrawX = chainFromX - (-dcos(hookAngle) * _dist);
	realDrawY = chainFromY - (dsin(hookAngle) * _dist);
}

if (state != hookState.onPlayer)
	draw_sprite(spr_hook_chain, 2, realDrawX, realDrawY);

draw_sprite_ext(spr_hook, 0, realDrawX, realDrawY, 1, 1, hookAngle, #FFFFFF, 1);
