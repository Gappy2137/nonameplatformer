
time = 0;
timeSpeed = .01;
windAngle = 0;
hitAngle = 0;
colAngle = 0;
resetColAngle = false;
resetColAngleTimerMax = 20;
resetColAngleTimer = resetColAngleTimerMax;
colAngleSpd = 2;
randomAngleSpd = obj_game.randomWindSpeedArray[irandom_range(0, 9)];
randomTimeSpd = obj_game.randomWindSpeedArray[irandom_range(0, 9)];

drawUnder = true;