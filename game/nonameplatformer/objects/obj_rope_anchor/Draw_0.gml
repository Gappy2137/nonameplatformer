if (setupTimer > 0) exit;

//physics_draw_debug();
//draw_self();
draw_set_color(#FFFFFF);
/*
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
*/


var p0 = [phy_position_x, phy_position_y];
var p1 = [bezierX1,bezierY1];
var p2 = [bezierX2,bezierY2];
var p3 = [obj_player.x, obj_player.y];

var q0 = bezier_points(0, p0, p1, p2, p3);

var seg = 10;
var i = 1;

//draw_circle(p0[0],p0[1],1,false);
//draw_circle(p1[0],p1[1],1,false);
//draw_circle(p2[0],p2[1],1,false);
//draw_circle(p3[0],p3[1],1,false);

repeat(seg) {
	var t = i / seg;
	var q1 = bezier_points(t, p0, p1, p2, p3);
	draw_line_width(q0[0],q0[1],q1[0],q1[1], 1);
	q0=q1;
	i++;
}

