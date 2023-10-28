camMinX = 0;
camMinY = 0;
camMaxX = room_width;
camMaxY = room_height;

if (following != noone) {
	
	following = id;
	camX = following.x;
	camY = following.y;
	
}

view_set_camera(MAIN_VIEWPORT, camera);