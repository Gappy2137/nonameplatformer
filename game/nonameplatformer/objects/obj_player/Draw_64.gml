draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_left);
draw_text(0,0 + (16*i++),"x:             " + string(x));
draw_text(0,0 + (16*i++),"y:             " + string(y));
draw_text(0,0 + (16*i++),"hsp:           " + string(hsp));
draw_text(0,0 + (16*i++),"vsp:           " + string(vsp));
draw_text(0,0 + (16*i++),"state:         " + string(state));
draw_text(0,0 + (16*i++),"hooked:        " + string(hookedState));
draw_text(0,0 + (16*i++),"inAir:         " + string(inAir));
draw_text(0,0 + (16*i++),"isJumping:     " + string(isJumping));
draw_text(0,0 + (16*i++),"hookAtMax:     " + string(hookAtMax));