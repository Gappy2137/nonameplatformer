
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
launchTimeMax = 30;

maxRange = 196;
slowDownRange = round(maxRange / 3);
freeRange = round(maxRange / 8);
hookPullEnd = false;

angleToMouse = 0;

drawX = x;
drawY = y;
chainFromX = x;
chainFromY = y;
timeToEmbed = 0;
embedTimer = 0;

canUse = true;
