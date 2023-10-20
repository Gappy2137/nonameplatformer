//physics_draw_debug();
//draw_self();
draw_set_color(#FFFFFF);

draw_line_width(
	phy_position_x,
	phy_position_y,
	ropeArray[0].phy_position_x,
	ropeArray[0].phy_position_y,
	1
);

var i = 0;

repeat(array_length(ropeArray) - 1) {

	if (ropeArray[i] != noone) && (ropeArray[i + 1] != noone)
		draw_line_width(
			ropeArray[i].phy_position_x,
			ropeArray[i].phy_position_y,
			ropeArray[i + 1].phy_position_x,
			ropeArray[i + 1].phy_position_y,
			1
		);

	i++;

}