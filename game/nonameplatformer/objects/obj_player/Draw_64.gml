
draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_right);
draw_text(GAME_WIDTH,0 + (16*i++),"x:" + string(x));
draw_text(GAME_WIDTH,0 + (16*i++),"y:" + string(y));
draw_text(GAME_WIDTH,0 + (16*i++),"hsp:" + string(hsp));
draw_text(GAME_WIDTH,0 + (16*i++),"vsp:" + string(vsp));
draw_text(GAME_WIDTH,0 + (16*i++),"state:" + string(state));
draw_text(GAME_WIDTH,0 + (16*i++),"hooked:" + string(hookedState));
draw_text(GAME_WIDTH,0 + (16*i++),"inAir:" + string(inAir));
draw_text(GAME_WIDTH,0 + (16*i++),"isJumping:" + string(isJumping));
draw_text(GAME_WIDTH,0 + (16*i++),"deccel:" + string(deccel));
draw_text(GAME_WIDTH,0 + (16*i++),"jumpsLeft:" + string(jumpsLeft));
draw_text(GAME_WIDTH,0 + (16*i++),"isFalling:" + string(isFalling));
draw_text(GAME_WIDTH,0 + (16*i++),"jumpTrigger:" + string(jumpTrigger));