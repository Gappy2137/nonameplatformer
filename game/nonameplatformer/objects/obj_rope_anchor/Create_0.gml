anchorX = 0;
anchorY = 0;
depth = obj_player.depth - 1;

bezierX1=anchorX;
bezierY1=anchorY;
bezierX2=obj_player.x;
bezierY2=obj_player.y;

ropePieces = 6;
ropePieceMaxLength = .3;
ropeArray = array_create(ropePieces, noone);
jointArray = array_create(ropePieces, 0);

setupTimer = 1;

var ID = 0;

if (obj_roomcontrol.enablePhy) {
	
	//ropeArray[0][ID] = instance_create_layer(anchorX, anchorY, LAYER_INST, obj_rope_part);
	//ropeArray[0][_X] = anchorX;
	//ropeArray[0][_Y] = anchorY;
	
	var fixture = physics_fixture_create();
	physics_fixture_set_circle_shape(fixture, 1);
	physics_fixture_set_density(fixture, 0);
	physics_fixture_bind(fixture, id);
	
	//var attach = physics_joint_rope_create(id, next, id.x, id.y, next.x, next.y, 2, true);
	//physics_joint_set_value(attach, phy_joint_max_length, ropePieceMaxLength);
	
	physics_fixture_delete(fixture);
	
	//ropeArray[0][ID]._parent = other.id;
	
	ropeArray[0] = instance_create_layer(obj_hook.x, obj_hook.y, LAYER_INST, obj_rope_part);
	jointArray[ropePieces - 1] = physics_joint_rope_create(id, ropeArray[0], phy_position_x, phy_position_y, ropeArray[0].x, ropeArray[0].y, ropePieceMaxLength, false);
	physics_joint_set_value(jointArray[ropePieces - 1], phy_joint_max_length, ropePieceMaxLength);
	//jointArray[ropePieces - 1] = attachFirst;

	var angle = point_direction(obj_player.x, obj_player.y, obj_hook.x, obj_hook.y); 

	var i = 1;
	
	repeat(ropePieces - 1) {
		
		var _p = (i == ropePieces - 1 ? true : false);
		
		var mx = -lengthdir_x(i * (ropePieceMaxLength * 32), angle);
		var my = -lengthdir_y(i * (ropePieceMaxLength * 32), angle);
		
		ropeArray[i] = instance_create_layer(obj_hook.x + mx, obj_hook.y + my, LAYER_INST, obj_rope_part, {
		
			lastPiece: _p,
			x: obj_hook.x + mx,
			y: obj_hook.y + my
		
		});

		i++;
	
	}
	
	i = ropePieces - 2;
	
	repeat(ropePieces - 1) {
	
		jointArray[i] = physics_joint_rope_create(ropeArray[i], ropeArray[i + 1], ropeArray[i].x, ropeArray[i].y, ropeArray[i + 1].x, ropeArray[i + 1].y, ropePieceMaxLength, false);
		
		physics_joint_set_value(jointArray[i], phy_joint_max_length, ropePieceMaxLength);
		
		//jointArray[i] = attach;
		
		ropeArray[i].joint = jointArray[i + 1];
	
		i--;
	
	}
	
	
}