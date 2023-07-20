

var cam_x = clamp((following.x-(view_width/2)),xRel , xRel + widthRel-(view_width));
var cam_y = clamp((following.y-(view_height/2) + _y),yRel, yRel + heightRel-(view_height));		
				
var cam_x_pos = camera_get_view_x(MAIN_CAMERA);
var cam_y_pos = camera_get_view_y(MAIN_CAMERA);
				
var cam_speed = 0.2;
						
var xl = (round_to4(lerp(cam_x_pos,cam_x,cam_speed)));
var yl = (round_to4(lerp(cam_y_pos,cam_y,cam_speed)));

camera_set_view_pos(MAIN_CAMERA, xl, yl);	
						
camX = cam_x;
camY = cam_y;