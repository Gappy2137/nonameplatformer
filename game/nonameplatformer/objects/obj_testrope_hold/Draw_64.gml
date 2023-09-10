draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_left);
draw_text(0,0 + (16*i++),"x:    " + string(ropeArray[0].phy_position_x));
draw_text(0,0 + (16*i++),"y:    " + string(ropeArray[0].phy_position_y));
draw_text(0,0 + (16*i++),"lx:   " + string(ropeArray[ropePieces - 1].phy_position_x));
draw_text(0,0 + (16*i++),"ly:   " + string(ropeArray[ropePieces - 1].phy_position_y));
draw_text(0,0 + (16*i++),"_l:   " + string(ropePieceMaxLength));
