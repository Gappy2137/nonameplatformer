obj_camera.following = id;

counter = 0;

slopeup = 0;
slopedown = 0;

spdBase = 2;
spd = spdBase;
hsp = 0;
vsp = 0;
jumpForce = 2.55;

dir = 0;
facing = 1;

gravBase = 0.15;
grav = gravBase;
gravDir = 270;

accel = 0.4;
deccel = 0.2;

hspMax = 8;
vspMin = -9;
vspMax = 4.5;

canJump = true;
isJumping = false;
isFalling = true;
isGrounded = false;
inAir = true;
isSkidding = false;
isTurning = false;

jumpTimeThreshold = 10;
jumpTime = 0;

jumpBufferMax = 6;
jumpBuffer = 0;

coyoteTime = 0;
coyoteMax = 6;

var _my_method = function(){
	instance_create_layer(x,y,"Instances",obj_trail);
}

var trail = time_source_create(time_source_game, 1, time_source_units_frames, _my_method, [], -1);
time_source_start(trail);
