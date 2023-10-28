if (roomTransition) {

	if (transTime >= transMax) roomTransition = false; else ++transTime;
	
	if (nextRoom != undefined) && (!roomTrigger) {
		
		//room_goto(nextRoom);
		roomTrigger = true;
		
	}

} else {
	
	transTime = 0;
	roomTrigger = false;
	obj_camera.following = obj_player;
	firstSurfReady = false;
	gotoRoom = false;
	surface_free(surfCurrRoom);
	surface_free(surfNextRoom);
	
}

if keyboard_check_pressed(ord("Q")) {
    global.game.debug = !global.game.debug;
    show_debug_overlay(global.game.debug);
}

if (!global.game.debug) {
	
	if keyboard_check_pressed(ord("T")) {
		if global.game.windowSize > 1
		global.game.game_set_size(--global.game.windowSize);
	}
	if keyboard_check_pressed(ord("Y")) {
		global.game.game_set_size(++global.game.windowSize);
	}
	if keyboard_check_pressed(ord("G")) {
		game_set_speed(5, gamespeed_fps);
		physics_world_update_speed(100);
	}
	if keyboard_check_pressed(ord("H")) {
		game_set_speed(60, gamespeed_fps);
		physics_world_update_speed(60);
	}
}

global.game.mouseX = device_mouse_x_to_gui(0);
global.game.mouseY = device_mouse_y_to_gui(0);

global.game.mouseXR = mouse_x;
global.game.mouseYR = mouse_y;

