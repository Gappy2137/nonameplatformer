/// @description Setup

//show_debug_overlay(true);

application_surface_draw_enable(true);

appSurf = -1;

randomize();

// Makra

#macro GAME_WIDTH 480
#macro GAME_HEIGHT 270

#macro MAIN_VIEWPORT 0
#macro MAIN_CAMERA view_camera[MAIN_VIEWPORT]

#macro LAYER_GAME "Game"
#macro LAYER_INST "Instances"
//#macro LAYER_UI "UI"

#macro DEPTH_CURSOR 1_000_001
#macro DEPTH_UI		1_000_000

// Enum

enum cursorSprite {

	normal =	0,
	hook =		1,
	hookReady =	2

}

enum hookState {

	onPlayer = 0,
	launched = 1,
	released = 2,
	embedded = 3

}

enum playerState {

	idle =		0,
	walking =	1,
	offhook =	2,
	onhook =	3,
	wallslide = 4,
	dead =		5
	
}

enum playerHookedState {

	pull = 0,
	fall = 1,
	none = 2

}

enum roomTrans {

	right =	 0,
	up =	 1,
	left =	 2,
	down =	 3,

}

enum weaponEnum {

	none =		0,
	hook =		1,
	pistol =	2

}

enum playerSprite {

	idle		= 0,
	run			= 1,
	jump		= 2,
	wallslide	= 3,
	lookup		= 4,
	dead		= 5

}

// Glowne zmienne

x = 0;
y = 0;

global.game = {
	
	debugMode: true,
	
	mouseX: device_mouse_x_to_gui(0),
	mouseY: device_mouse_y_to_gui(0),
	
	mouseXR: mouse_x,
	mouseYR: mouse_y,

	windowWidth: GAME_WIDTH,
	windowHeight: GAME_HEIGHT,
	
	windowMaxWidth: display_get_width(),
	windowMaxHeight: display_get_height(),
	
	aspectRatio: GAME_WIDTH / GAME_HEIGHT,
	
	windowSize: 1,
	
	cursorType: cursorSprite.hook,
	
	debug: false,
	
	currentRoom: undefined,
	
	nextRoom: undefined,
	
	game_set_size : function(newSize) {
		
		windowSize = newSize;
		windowWidth = GAME_WIDTH * windowSize;
		windowHeight = GAME_HEIGHT * windowSize;
		
		surface_resize(application_surface, windowWidth, windowHeight);
		display_set_gui_size(GAME_WIDTH, GAME_HEIGHT);
		window_set_size(windowWidth, windowHeight);
		window_center();
		
		show_debug_message("Set window size to: " + string(windowSize));

	}

};

// Room transition
gameStart = true;alarm[0]=10;
roomTransition = false;
transOrientation = roomTrans.right;
transMax = 10;
transTime = 0;
roomToX = 0;
roomToY = 0;
nextRoom = undefined;
roomTrigger = false;
firstSurfReady = false;
gotoRoom = false;
roomTransPlayerVars = [];

ch=0;

surfCurrRoom = -1;
surfNextRoom = -1;


// Other

curveWind = animcurve_get_channel(curve_wind, "angle");
randomWindSpeedArray = [.8, .9, 1.0, 1.1, 1.2, 1.3, 0.88, 1.11, 0.92, 1.06];

// Particle system based on structs
// If _image is set to -1 it picks random subimage from _spr
// Type: 0 - particle goes in random direction with gravity - landing dust
// Type: 1 - stationary particle, grows and disappears - jump orb halo
// Type: 2 - particle goes in random direction with gravity (1 size) - shards

function particleFX(_x, _y, _spr, _color, _image, _type) constructor {
	
	xx = _x;
	yy = _y;
	sprite = _spr;
	color = _color;
	image = (_image == -1 ? irandom(_image) : _image);
	type = _type;
	
	alpha = 1;
	randomDec = round_to_2(random_range(.025, .2));
	randomDir = choose(-1, 1);
	grav = .1;
	fric = .1;
	
	hsp = 0;
	vsp = 0;
	
	switch (type) {
		case 0:
		
			dir = irandom_range(0, 180); 
			size = random_range(.5, 1.25);
			spd = random_range(.5, .75);
			angle = irandom(359);
			
		break;
		
		case 1:
		
			dir = 0;
			size = .5;
			spd = 0;
			angle = 0;
			
		break;
		
		case 2:
		
			dir = irandom_range(0, 359);
			size = 1;
			spd = random_range(.75, 1);
			angle = irandom(359);
			
		break;
	}
	
	Step = function() {
	
		switch (type) {
		
			case 0:
			
				size -= randomDec * .25;
				angle += randomDec * 50 * randomDir;
				alpha -= randomDec * .75;
		
				grav += .01;
				
				hsp = lengthdir_x(spd, dir);
				vsp = (lengthdir_y(spd, dir) * .75) + grav;
		
				xx += hsp;
				yy += vsp;
			
			break;
			
			case 1:
			
				size += randomDec * .35;
				alpha -= randomDec * .25;
			
			break;
			
			case 2:
			
				angle += randomDec * 100 * randomDir;
				alpha -= randomDec * .25;
		
				grav += .01;
				fric += .01;
				
				grav = clamp(grav, 0, .5);
				fric = clamp(fric, 0, .5);
		
				hsp = lerp(lengthdir_x(spd, dir), 0, fric);
				vsp = lerp(lengthdir_y(spd, dir), 0, grav);
				
				xx += hsp;
				yy += vsp;
			
			break;
		
		}
	
	}
	
	Draw = function() {
		
		draw_sprite_ext(sprite, image, xx, yy, size, size, angle, color, alpha);
		
	}
	
}

// Culling

c=0;

cullTimer = time_source_create(time_source_game, 4, time_source_units_frames, cullScreen, [], -1);
time_source_start(cullTimer);

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

window_set_cursor(cr_none);


// Always available (like static or singleton idk)
instance_create_layer(0, 0, LAYER_GAME, obj_camera);
instance_create_layer(0, 0, LAYER_GAME, obj_cursor);
instance_create_layer(0, 0, LAYER_GAME, obj_inventory);
instance_create_layer(0, 0, LAYER_GAME, obj_particlesystem);

// Przenies z pokoju init do kolejnego
room_goto(rm_devroom);