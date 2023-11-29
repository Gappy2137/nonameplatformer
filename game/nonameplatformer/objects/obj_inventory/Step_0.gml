
if (obj_player.state == playerState.onhook) {

	canChange = false;

} else {

	canChange = true;

}

if (canChange) {
	
	if (mouse_wheel_down()) {

		if (equipped < array_length(dsInv) - 1) {
		
			equipped++;
			obj_player.weaponSpriteInd = obj_player.weaponSprite[equipped];
		
		}

	}

	if (mouse_wheel_up()) {

		if (equipped > 0) {
		
			equipped--;
			obj_player.weaponSpriteInd = obj_player.weaponSprite[equipped];
		
		}

	}
	
}