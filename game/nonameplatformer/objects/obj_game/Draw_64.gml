var _w = global.game.windowWidth, _h = global.game.windowHeight;

var size = 1 / global.game.windowSize;

if (!surface_exists(surfCurrRoom))
	surfCurrRoom = surface_create(_w, _h);
	
if (!surface_exists(surfNextRoom))
	surfNextRoom = surface_create(_w, _h);

if (roomTrigger) && (!gotoRoom) {
	
	surface_set_target(surfCurrRoom);

	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface_part(application_surface, 0, 0, _w, _h, 0, 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	
	gotoRoom = true;
	
	room_goto(nextRoom);
	
}

if (firstSurfReady) {
	
	
	
	event_user(0);

	surface_set_target(surfNextRoom);

	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface_part(application_surface, 0, 0, _w, _h, 0, 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();

}

if (transTime > 1) {
	
	var oldX = 0, oldY = 0, newX = 0, newY = 0;
	
	var val = transTime / transMax;
	
	switch(transOrientation) {
	
		case roomTrans.right:
			oldX = -(val * GAME_WIDTH);
			oldY = 0;
			newX = GAME_WIDTH * (1 - val);
			newY = 0;
		break;
		case roomTrans.up:
			oldX = 0;
			oldY = (val * GAME_HEIGHT);
			newX = 0;
			newY = -GAME_HEIGHT * (1 - val);
		break;
		case roomTrans.left:
			oldX = (val * GAME_WIDTH);
			oldY = 0;
			newX = -GAME_WIDTH * (1 - val);
			newY = 0;
		break;
		case roomTrans.down:
			oldX = 0;
			oldY = -(val * GAME_HEIGHT);
			newX = 0;
			newY = GAME_HEIGHT * (1 - val);
		break;
	
	}

	draw_surface_ext(surfCurrRoom, oldX, oldY, size, size, 0, #FFFFFF, 1);
	draw_surface_ext(surfNextRoom, newX, newY, size, size, 0, #FFFFFF, 1);
	
}

draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_right);

draw_text(GAME_WIDTH,0 + (16*i++),"transTime:" + string(transTime));
draw_text(GAME_WIDTH,0 + (16*i++),"roomTrigger:" + string(roomTrigger));