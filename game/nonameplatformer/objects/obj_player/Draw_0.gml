//draw_sprite_ext(spr_player_idle, 0, x, y, 1, 1, 0, #FFFFFF, 1);

//draw_sprite_ext(spriteInd, animFrame, x, y, facing, 1, 0, #FFFFFF, 1);

var realPos = [];

var cosine = dcos(angle);
var sine = dsin(angle);

//realPos[0] = [(sprPos[0][0] * cosine) - (sprPos[0][1] * sine), (sprPos[0][0] * sine) + (sprPos[0][1] * cosine)];
//realPos[1] = [(sprPos[1][0] * cosine) - (sprPos[1][1] * sine), (sprPos[1][0] * sine) + (sprPos[1][1] * cosine)];
//realPos[2] = [(sprPos[2][0] * cosine) - (sprPos[2][1] * sine), (sprPos[2][0] * sine) + (sprPos[2][1] * cosine)];
//realPos[3] = [(sprPos[3][0] * cosine) - (sprPos[3][1] * sine), (sprPos[3][0] * sine) + (sprPos[3][1] * cosine)];

realPos[0] = [x + ((facing != -1 ? sprPos[0][0] : sprPos[1][0]) * cosine) - (sprPos[0][1] * sine), y + ((facing != -1 ? sprPos[0][0] : sprPos[1][0]) * sine) + (sprPos[0][1] * cosine)];
realPos[1] = [x + ((facing != -1 ? sprPos[1][0] : sprPos[0][0]) * cosine) - (sprPos[1][1] * sine), y + ((facing != -1 ? sprPos[1][0] : sprPos[0][0]) * sine) + (sprPos[1][1] * cosine)];
realPos[2] = [x + ((facing != -1 ? sprPos[2][0] : sprPos[3][0]) * cosine) - (sprPos[2][1] * sine), y + ((facing != -1 ? sprPos[2][0] : sprPos[3][0]) * sine) + (sprPos[2][1] * cosine)];
realPos[3] = [x + ((facing != -1 ? sprPos[3][0] : sprPos[2][0]) * cosine) - (sprPos[3][1] * sine), y + ((facing != -1 ? sprPos[3][0] : sprPos[2][0]) * sine) + (sprPos[3][1] * cosine)];

//draw_circle(realPos[0][0], realPos[0][1], 1, false);
//draw_circle(realPos[1][0], realPos[1][1], 1, false);
//draw_circle(realPos[2][0], realPos[2][1], 1, false);
//draw_circle(realPos[3][0], realPos[3][1], 1, false);

draw_sprite_pos(spriteInd, animFrame, realPos[0][0] + juicePos[0][0] * facing, realPos[0][1] + juicePos[0][1],
									  realPos[1][0] + juicePos[1][0] * facing, realPos[1][1] + juicePos[1][1],
									  realPos[2][0] + juicePos[2][0] * facing, realPos[2][1] + juicePos[2][1],
									  realPos[3][0] + juicePos[3][0] * facing, realPos[3][1] + juicePos[3][1],
									  1);

draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_center);

//draw_text(x,y + 16 + (16*i++),"spriteInd:" + string(sprite_get_name(spriteInd)));
//draw_text(x,y + 16 + (16*i++),"animFrame:" + string(animFrame));
draw_text(x,y + 16 + (16*i++),"landed:" + string(landed));
draw_text(x,y + 16 + (16*i++),"juiceT:" + string(juiceT));
/*
draw_set_color(#FFFF00);
draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
draw_set_color(#000000);
*/