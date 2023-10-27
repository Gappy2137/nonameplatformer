if (!surface_exists(surfCurrRoom))
	surfCurrRoom = surface_create(global.game.windowWidth, global.game.windowHeight);

if (!surface_exists(surfNextRoom))
	surfNextRoom = surface_create(global.game.windowWidth, global.game.windowHeight);

if (transTime > 2) {
	
	var oldX = 0, oldY = 0, newX = 0, newY = 0;
	
	switch(transOrientation) {
	
		case roomTrans.right:
			oldX = (transTime / transMax) * -GAME_WIDTH;
			oldY = 0;
			newX = (-transTime / transMax) * GAME_WIDTH;
			newY = 0;
		break;
		case roomTrans.up:
			oldX = 0;
			oldY = (1 - transTime / transMax) * GAME_HEIGHT;
			newX = 0;
			newY = (-transTime / transMax) * GAME_HEIGHT;
		break;
		case roomTrans.left:
			oldX = (1 - transTime / transMax) * GAME_WIDTH;
			oldY = 0;
			newX = (-transTime / transMax) * GAME_WIDTH;
			newY = 0;
		break;
		case roomTrans.down:
			oldX = 0;
			oldY = (1 + transTime / transMax) * GAME_HEIGHT;
			newX = 0;
			newY = (transTime / transMax) * GAME_HEIGHT;
		break;
	
	}
	
	draw_surface(surfCurrRoom, oldX, oldY);
	draw_surface(surfNextRoom, newX, newY);
	
}

draw_set_color(#FFFFFF);

var i = 0;
draw_set_halign(fa_right);

draw_text(GAME_WIDTH,0 + (16*i++),"transTime:" + string(transTime));