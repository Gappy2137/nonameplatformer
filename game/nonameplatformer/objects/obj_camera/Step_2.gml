

var cam_x = clamp((following.x - (camWidth/2)), camMinX , camMaxX);
var cam_y = clamp((following.y - (camHeight/2)) - 16, camMinY, camMaxY);		
				
var cam_x_pos = camera_get_view_x(MAIN_CAMERA);
var cam_y_pos = camera_get_view_y(MAIN_CAMERA);
				
var cam_speed = 0.2;
						
var _x = lerp(cam_x_pos, cam_x, cam_speed);
var _y = lerp(cam_y_pos, cam_y, cam_speed);

camera_set_view_pos(MAIN_CAMERA, _x, _y);	

