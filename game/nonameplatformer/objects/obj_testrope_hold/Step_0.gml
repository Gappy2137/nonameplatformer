phy_position_x = anchorX;
phy_position_y = anchorY;

if (keyboard_check(ord("W"))) ropePieceMaxLength-=.005;
if (keyboard_check(ord("S"))) ropePieceMaxLength+=.005;

ropePieceMaxLength = clamp(ropePieceMaxLength, 0.05, .5);

var i = 0;

repeat(array_length(jointArray)) {

	var _a = jointArray[i];
	var _l = ropePieceMaxLength;

	with (ropeArray[i]) {
	
		physics_joint_set_value(_a, phy_joint_max_length, _l);
	
	}

	i++;

}