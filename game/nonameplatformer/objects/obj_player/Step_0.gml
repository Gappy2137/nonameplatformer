event_inherited();

sprPos[0] = [-sprOffset, -sprOffset];
sprPos[1] = [+sprOffset, -sprOffset];
sprPos[2] = [+sprOffset, +sprOffset];
sprPos[3] = [-sprOffset, +sprOffset];

// Process logic
scr_player_logic();

// Process movement
scr_player_movement();

// Process animations
scr_player_anim();

if keyboard_check(ord("J")) v-=.1;
if keyboard_check(ord("K")) v+=.1;

if (!landingAnim)
	landed = false;
