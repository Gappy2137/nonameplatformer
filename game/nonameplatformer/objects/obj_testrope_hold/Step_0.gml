phy_position_x = anchorX;
phy_position_y = anchorY;

if (keyboard_check(ord("V"))) ropePieceMaxLength-=.01;
if (keyboard_check(ord("B"))) ropePieceMaxLength+=.01;

var i = 0;

repeat(array_length(jointArray)) {

	var _a = jointArray[i];
	var _l = ropePieceMaxLength;

	with (ropeArray[i]) {
	
		physics_joint_set_value(_a, phy_joint_max_length, _l);
	
	}

	i++;

}