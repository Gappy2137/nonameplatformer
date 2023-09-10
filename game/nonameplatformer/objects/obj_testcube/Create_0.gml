if (obj_roomcontrol.enablePhy) {
	
	var fixture = physics_fixture_create();
	physics_fixture_set_box_shape(fixture, sprite_width/2, sprite_height/2);
	physics_fixture_set_density(fixture, 0.5);
	physics_fixture_set_restitution(fixture, 0.2);
	physics_fixture_set_friction(fixture, 0.2);
	physics_fixture_set_linear_damping(fixture, 0.2);
	physics_fixture_bind_ext(fixture, id, (sprite_width * .5) - 1, (sprite_height * .5) - 1);
	physics_fixture_delete(fixture);

}