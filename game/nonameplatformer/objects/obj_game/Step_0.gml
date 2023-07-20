if keyboard_check_pressed(ord("T")) {
	global.game.game_set_size(--global.game.windowSize);
}
if keyboard_check_pressed(ord("Y")) {
	global.game.game_set_size(++global.game.windowSize);
}