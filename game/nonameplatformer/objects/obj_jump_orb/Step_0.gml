if (collected) {

	if (regenTimer >= regenTimerMax) {
	
		animFrame = 0;
		regenTimer = 0;
		collected = false;
		event_user(1);
	
	}
		regenTimer++;
	
}