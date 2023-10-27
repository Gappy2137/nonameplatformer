obj_camera.following = id;

counter = 0;

slopeup = 0;
slopedown = 0;

state = playerState.idle;
hookedState = playerHookedState.none;
ignoreGravity = false;
hookAtMax = false;
onHookVel = 0;
onHookAngle = 0;
hookSetAngle = 0;

spdBase = 2;
spd = spdBase;
hsp = 0;
vsp = 0;
jumpForceBase = 2.15;
//2.55
jumpForce = jumpForceBase;

dir = 0;
facing = 1;

gravBase = 0.15;
grav = gravBase;
gravDir = 270;

accelGround = 0.4;
accelAir = 0.3;
deccelGround = 0.25;
deccelAir = 0.1;
deccelHook = 0.05;

accel = accelGround;
deccel = deccelGround;

hspMax = 6;
vspMin = -9;
vspMax = 6;

canJump = true;
isJumping = false;
isFalling = true;
isGrounded = false;
inAir = true;
isSkidding = false;
isTurning = false;

skidTimeMax = 10;
skidTime = 0;

jumpTimeThreshold = 10;
jumpTime = 0;

jumpBufferMax = 6;
jumpBuffer = 0;

coyoteTime = 0;
coyoteMax = 6;

justJumped = false;
jumpTrigger = false;
jumpAccel = 0.4;
jumpAccelThreshold = 10;
jumpAccelTime = jumpAccelThreshold;
jumpAccelTimeMax = -10;

jumpOffMax = 9;
jumpOffTime = 0;

offHookTrigger = false;
offHookTimerMax = 20;
offHookTimer = 0;
hspAtRelease = 0;

canDoubleJump = true;
jumpsMax = 1;
jumpsLeft = jumpsMax;
jumps = 0;

isSliding = false;
slideMax = 20;
slideTime = 0;

canWalljump = true;
wallSlideBase = .4;
wallSlideTimer = wallSlideBase;
isWallSliding = false;
wallJumpTrigger = false;
wallJumpMax = 18;
wallJumpTimer = wallJumpMax;
wallJump = 0;

animFrame = 0;
animFrameNum = 0;
animSpeed = 0;

idleSprite = spr_player_snow_idle;
runSprite = spr_player_snow_run;
jumpSprite = spr_player_snow_jump;
wallslideSprite = spr_player_snow_wallslide;

spriteInd = idleSprite;

angle = 0;
sprOffset = 12;
sprPos[0] = [-sprOffset, -sprOffset];
sprPos[1] = [+sprOffset, -sprOffset];
sprPos[2] = [+sprOffset, +sprOffset];
sprPos[3] = [-sprOffset, +sprOffset];

juicePos[0] = [0, 0];
juicePos[1] = [0, 0];
juicePos[2] = [0, 0];
juicePos[3] = [0, 0];

juiceT = 0;
juiceTSpeed = .1;
juiceTMax = 1;

curveJumpUp = animcurve_get_channel(curve_jumpUp, "squish");

landed = false;
landingAnim = false;

area = 0;

_prev = 0;
xPrev[0] = x;
yPrev[0] = y;
rewind = false;

instance_create_layer(x,y,LAYER_INST,obj_hook);
/*
var _my_method = function(){
	instance_create_layer(x,y,"Instances",obj_trail);
}

var trail = time_source_create(time_source_game, 1, time_source_units_frames, _my_method, [], -1);
time_source_start(trail);
*/