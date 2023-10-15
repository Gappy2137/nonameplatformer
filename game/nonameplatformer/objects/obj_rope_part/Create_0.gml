attachedTo = obj_rope_anchor;
depth = obj_player.depth - 1;
setupTimer = 5;
joint = 0;

if (obj_roomcontrol.enablePhy) {

	var fixture = physics_fixture_create();
	if (lastPiece) {
		physics_fixture_set_box_shape(fixture, 6.5, 7.5);
		physics_fixture_set_density(fixture, .3);
		physics_fixture_set_kinematic(fixture);
		physics_fixture_set_linear_damping(fixture, .5);
		//physics_fixture_set_angular_damping(fixture, 1);
		x = obj_player.x;
		y = obj_player.y;
	} else {
		physics_fixture_set_circle_shape(fixture, 2);
		physics_fixture_set_density(fixture, 2);
		physics_fixture_set_linear_damping(fixture, .1);
		physics_fixture_set_angular_damping(fixture, .1);
	}
	physics_fixture_bind(fixture, id);
	physics_fixture_delete(fixture);

}