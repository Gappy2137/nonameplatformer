obj_camera.following = id;

spdBase = 1;
spd = spdBase;
hsp = 0;
vsp = 0;

jumpForce = 2;

dir = 0;
facing = 1;

gravBase = 0.1;
grav = gravBase;
gravDir = 270;

accel = 0.6;
deccel = 0.3;

hspMax = 20;
vspMax = 9;

canJump = true;
isJumping = false;
isFalling = false;
isGrounded = false;
inAir = false;

var _my_method = function(){
	instance_create_layer(x,y,"Instances",obj_trail);
}

var trail = time_source_create(time_source_game, 1, time_source_units_frames, _my_method, [], -1);
time_source_start(trail);