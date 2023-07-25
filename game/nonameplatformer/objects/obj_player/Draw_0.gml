draw_sprite_ext(spr_player_idle, 0, x, y, 1, 1, 0, #FFFFFF, 1);

draw_set_color(#FFFF00);
draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
draw_set_color(#000000);