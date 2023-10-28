function cullScreen() {
	
	obj_game.c++;
	
	if (!instance_exists(obj_camera)) exit;
	
	var cullDist = 32;

	instance_deactivate_object(par_collision);
	instance_deactivate_object(par_entity);
	instance_deactivate_object(obj_walljump_8);
	instance_deactivate_object(obj_doublejump_8);
	instance_deactivate_object(obj_roomtrans_8);
	
	instance_activate_object(obj_player);
	instance_activate_object(obj_attachable_8);
	
	instance_activate_region(obj_camera.camMinX - cullDist,
					 		 obj_camera.camMinY - cullDist,
					 		 obj_camera.camMaxX + cullDist,
					 		 obj_camera.camMaxY + cullDist,
					 		 true);

}