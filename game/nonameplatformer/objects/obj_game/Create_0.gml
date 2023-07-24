/// @description Setup

// Makra

#macro GAME_WIDTH 480
#macro GAME_HEIGHT 270

#macro MAIN_VIEWPORT 0
#macro MAIN_CAMERA view_camera[MAIN_VIEWPORT]

// Glowne zmienne

x = 0;
y = 0;

global.game = {
	
	debugMode: true,
	
	mouseX: device_mouse_x_to_gui(0),
	mouseY: device_mouse_y_to_gui(0),

	windowWidth: GAME_WIDTH,
	windowHeight: GAME_HEIGHT,
	
	windowMaxWidth: display_get_width(),
	windowMaxHeight: display_get_height(),
	
	aspectRatio: GAME_WIDTH / GAME_HEIGHT,
	
	windowSize: 1,
	
	game_set_size : function(newSize) {
		
		windowSize = newSize;
		windowWidth = GAME_WIDTH * windowSize;
		windowHeight = GAME_HEIGHT * windowSize;
		
		surface_resize(application_surface, windowWidth, windowHeight);
		window_set_size(windowWidth, windowHeight);
		window_center();
		
		show_debug_message("Set window size to: " + string(windowSize));

	}

};

// Poczatkowe ustawienie wielkosci okna

global.game.game_set_size(1);

// Ustawienie viewportow w kazdym pokoju

for (var i = 1; i <= room_last; i++) {
    
	if (room_exists(i)) {
	
		room_set_viewport(i, MAIN_VIEWPORT, true,
		0, 0,
		GAME_WIDTH, GAME_HEIGHT);
		
		room_set_view_enabled(i, true);
		
	}
	
}

// Przenies z pokoju init do kolejnego
room_goto(rm_devroom);