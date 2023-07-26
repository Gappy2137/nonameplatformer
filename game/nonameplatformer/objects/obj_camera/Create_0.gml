
camX = 0;
camY = 0;

camWidth = GAME_WIDTH;
camHeight = GAME_HEIGHT;
camAngle = 0;

camMinX = 0;
camMinY = 0;
camMaxX = room_width - (camWidth);
camMaxY = room_height - (camHeight);

following = noone;

follow_type = 0;

camMoveBorderX = 32;
camMoveBorderY = 128;

// Ustaw kamere

camera = camera_create_view(0, 0, camWidth, camHeight, camAngle, following, -1, -1, camMoveBorderX, camMoveBorderY);

camera_set_view_size(MAIN_CAMERA, camWidth, camHeight);

camera_apply(camera);