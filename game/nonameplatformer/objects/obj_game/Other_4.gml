if (!instance_exists(obj_player)) {

	instance_create_layer(roomToX, roomToY, LAYER_INST, obj_player);
	
}

if (gameStart) || (transTime < 2)  exit;

if (!surface_exists(surfNextRoom))
	surfNextRoom = surface_create(global.game.windowWidth, global.game.windowHeight);
	
surface_set_target(surfNextRoom);

draw_surface_part(application_surface, obj_camera.camX, obj_camera.camY, GAME_WIDTH, GAME_HEIGHT, obj_camera.camX, obj_camera.camY);

surface_reset_target();