if (setupTimer <= 0) setupTimer = 0; else setupTimer--;

phy_position_x = anchorX;
phy_position_y = anchorY;

if (keyboard_check(ord("W"))) ropePieceMaxLength-=.005;
if (keyboard_check(ord("S"))) ropePieceMaxLength+=.005;

ropePieceMaxLength = clamp(ropePieceMaxLength, 0.2, .6);

var i = 0;

repeat(array_length(jointArray)) {

	var _a = jointArray[i];
	var _l = ropePieceMaxLength;

	with (ropeArray[i]) {
	
		physics_joint_set_value(_a, phy_joint_max_length, _l);
	
	}

	i++;

}
var val = 1;
if (keyboard_check(ord("J"))) if keyboard_check(vk_control) bezierX1-=val; else bezierX1+=val;
if (keyboard_check(ord("K"))) if keyboard_check(vk_control) bezierY1-=val; else bezierY1+=val;
if (keyboard_check(ord("N"))) if keyboard_check(vk_control) bezierX2-=val; else bezierX2+=val;
if (keyboard_check(ord("M"))) if keyboard_check(vk_control) bezierY2-=val; else bezierY2+=val;

bezierX1=phy_position_x;
bezierY1=phy_position_y;

var len = point_distance(obj_player.x,obj_player.y,phy_position_x,phy_position_y) * .5;
var dir = point_direction(obj_player.x,obj_player.y,phy_position_x,phy_position_y);

bezierX2=obj_player.x + lengthdir_x(len, dir + obj_player.hsp*8);
bezierY2=obj_player.y + lengthdir_y(len, dir + obj_player.vsp*8);