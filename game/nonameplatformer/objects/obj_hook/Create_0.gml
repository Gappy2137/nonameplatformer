
depth = obj_player.depth - 1;

hookAngle = 0;

state = hookState.onPlayer;
launchAngle = 0;
embeddedTo = noone;

anchorX = -1;
anchorY = -1;

spdBase = 16;
launchSpd = spdBase;
releaseSpd = spdBase;
hsp = 0;
vsp = 0;
dir = 0;

catchTime = 0;
catchTimeMax = 20;

launchTime = 0;
launchTimeMax = 100;

maxRange = 164;
slowDownRange = round(maxRange / 3);
freeRange = round(maxRange / 7);
hookPullEnd = false;

angleToMouse = 0;

drawX = x;
drawY = y;
chainFromX = x;
chainFromY = y;
timeToEmbed = 0;
embedTimer = 0;

canUse = true;

ropeImpulse = 0;
ropeID = noone;
ropeDrawTimer = 5;