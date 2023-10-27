draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_left);

draw_text(0,0 + (16*i++),"area:" + string(obj_player.area));

draw_text(0,0 + (16*i++),"camMinX:" + string(camMinX));
draw_text(0,0 + (16*i++),"camMinY:" + string(camMinY));
draw_text(0,0 + (16*i++),"camMaxX:" + string(camMaxX));
draw_text(0,0 + (16*i++),"camMaxY:" + string(camMaxY));
draw_text(0,0 + (16*i++),"camX:" + string(camX));
draw_text(0,0 + (16*i++),"camY:" + string(camY));