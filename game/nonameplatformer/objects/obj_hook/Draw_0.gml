
draw_sprite_ext(spr_hook, 2, drawX, drawY, 1, 1, hookAngle, #FFFFFF, 1);

draw_set_color(#FF0000);

a = raycast(x,y,x+lengthdir_x(maxRange, angleToMouse), y+lengthdir_y(maxRange, angleToMouse), par_collision);
if a[0] != noone
draw_line(x,y,a[1], a[2]);