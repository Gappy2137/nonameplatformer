function shakeScreen(intensity, duration) {
	
	with (obj_camera) {
		
		shakeDuration = duration * game_get_speed(gamespeed_fps);
		shakeIntensity = intensity;
		shakeTrigger = true;
		
	}
	
}