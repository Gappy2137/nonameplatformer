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

// FX
if (landed) && (justLanded) && (!inAir) && (isGrounded) {
	
	if (instance_place(x, y, obj_dustpart_8)) {
		
		newParticle(x, y + sprite_yoffset, spr_dust_part, #885041, 3, 0);

	}
	
	justLanded = false;

}

if keyboard_check(ord("J")) v-=.1;
if keyboard_check(ord("K")) v+=.1;

