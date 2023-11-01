if (setupTimer >= setupMax) setupTimer = setupMax; else setupTimer++;

if (shakeTrigger) {

	if (shakeTimer >= shakeDuration) {
	
		shakeTimer = 0;
		shakeTrigger = false;
		shakeX = 0;
		shakeY = 0;
		shakeDuration = 0;
		shakeIntensity = 0;
	
	} else {

		shakeTimer++;
		
		obj_camera.shakeX = random_range(-2, 2) * shakeIntensity;
		obj_camera.shakeY = random_range(-2, 2) * shakeIntensity;

	}

}

if (obj_game.roomTransition) {

	following = noone;

}