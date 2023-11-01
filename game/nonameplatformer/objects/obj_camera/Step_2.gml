if (following == noone) exit;

var currentArea = obj_player.area - 1;

if (currentArea < 0) {

	camMinX = 0;
	camMinY = 0;
	camMaxX = room_width;
	camMaxY = room_height;

} else {
	
	camMinX = obj_roomcontrol.areaArray[currentArea][1];
	camMinY = obj_roomcontrol.areaArray[currentArea][2];
	camMaxX = camMinX + obj_roomcontrol.areaArray[currentArea][3];
	camMaxY = camMinY + obj_roomcontrol.areaArray[currentArea][4];
	
}

camX = camera_get_view_x(MAIN_CAMERA);
camY = camera_get_view_y(MAIN_CAMERA);

var cam_x = clamp((following.x - (camWidth/2)), camMinX , camMaxX - camWidth);
var cam_y = clamp((following.y - (camHeight/2)) - 16, camMinY, camMaxY - camHeight);		
					
var cam_speed = (setupTimer == setupMax ? 0.2 : 1);
						
var _x = lerp(camX, cam_x, cam_speed);
var _y = lerp(camY, cam_y, cam_speed);

camera_set_view_pos(MAIN_CAMERA, _x + shakeX, _y + shakeY);	