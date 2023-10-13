event_inherited();

if (obj_roomcontrol.enablePhy) {
	
	var fixture = physics_fixture_create();
	physics_fixture_set_polygon_shape(fixture);
	physics_fixture_add_point(fixture, 0, 8);
	physics_fixture_add_point(fixture, 0, 0);
	physics_fixture_add_point(fixture, 8, 8);
	physics_fixture_set_density(fixture, 0);
	physics_fixture_set_restitution(fixture, 0);
	physics_fixture_set_friction(fixture, 0);
	physics_fixture_bind_ext(fixture, id, -1, -1);
	physics_fixture_delete(fixture);

}