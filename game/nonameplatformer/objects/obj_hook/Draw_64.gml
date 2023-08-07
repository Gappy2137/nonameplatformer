draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_right);
draw_text(GAME_WIDTH,0 + (16*i++),"x:" + string(x));
draw_text(GAME_WIDTH,0 + (16*i++),"y:" + string(y));
draw_text(GAME_WIDTH,0 + (16*i++),"drawX:" + string(drawX));
draw_text(GAME_WIDTH,0 + (16*i++),"drawY:" + string(drawY));
draw_text(GAME_WIDTH,0 + (16*i++),"hsp:" + string(hsp));
draw_text(GAME_WIDTH,0 + (16*i++),"vsp:" + string(vsp));
draw_text(GAME_WIDTH,0 + (16*i++),"state:" + string(state));
draw_text(GAME_WIDTH,0 + (16*i++),"angle:" + string(hookAngle));
draw_text(GAME_WIDTH,0 + (16*i++),"anchorX:" + string(anchorX));
draw_text(GAME_WIDTH,0 + (16*i++),"anchorY:" + string(anchorY));
draw_text(GAME_WIDTH,0 + (16*i++),"embeddedTo:" + string(embeddedTo));
draw_text(GAME_WIDTH,0 + (16*i++),"timeToEmbed:" + string(timeToEmbed));
draw_text(GAME_WIDTH,0 + (16*i++),"embedTimer:" + string(embedTimer));