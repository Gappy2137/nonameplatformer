if (gameStart) exit;

if (!surface_exists(surfCurrRoom))
	surfCurrRoom = surface_create(global.game.windowWidth, global.game.windowHeight);
	
surface_set_target(surfCurrRoom);

draw_surface_part(application_surface, obj_camera.camX, obj_camera.camY, GAME_WIDTH, GAME_HEIGHT, obj_camera.camX, obj_camera.camY);

surface_reset_target();