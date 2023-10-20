//draw_sprite_ext(spr_player_idle, 0, x, y, 1, 1, 0, #FFFFFF, 1);

draw_sprite_ext(spriteInd, animFrame, x, y, facing, 1, 0, #FFFFFF, 1);

draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_center);
/*
draw_text(x,y + 16 + (16*i++),"spriteInd:" + string(sprite_get_name(spriteInd)));
draw_text(x,y + 16 + (16*i++),"animFrame:" + string(animFrame));
draw_text(x,y + 16 + (16*i++),"facing:" + string(facing));
draw_text(x,y + 16 + (16*i++),"state:" + string(state));
/*
draw_set_color(#FFFF00);
draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
draw_set_color(#000000);
*/