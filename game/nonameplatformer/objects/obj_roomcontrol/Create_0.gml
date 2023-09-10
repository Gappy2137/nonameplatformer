if (enablePhy) {

	physics_world_create(1/32);
	physics_world_gravity(0, 9);
	physics_world_update_iterations(1);
	physics_world_update_speed(game_get_speed(gamespeed_fps));
	
}