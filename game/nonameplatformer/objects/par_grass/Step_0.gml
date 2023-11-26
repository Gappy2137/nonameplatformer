
if (time > 1) time = 0; else time += timeSpeed * randomTimeSpd;

var _wind = animcurve_channel_evaluate(obj_game.curveWind, time) * obj_roomcontrol.windStr * obj_roomcontrol.windDir;

windAngle = approach(windAngle, (randomAngleSpd * _wind * 2), 1);

if (resetColAngleTimer <= 0) {
	
	resetColAngleTimer = resetColAngleTimerMax;
	resetColAngle = true;
	
} else resetColAngleTimer--;

if (resetColAngle) {
	
	colAngle = approach(colAngle, 0, colAngleSpd);
	
}

if (resetColAngle) {
	
	if (colAngle > -4) && (colAngle < 4)
		colAngle = 0;	
	else
		colAngle = approach(colAngle, 0, colAngleSpd);
	
}