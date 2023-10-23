

// Parallax backgrounds

var camX = camera_get_view_x(MAIN_CAMERA);

//layer_x("parallax_background_1", camX * 0.5);
//layer_x("parallax_background_1", camX * 0.25);

var i = 0;

repeat(array_length(bgArray[0])) {
	
	if (bgArray[0, i] != 0)
		layer_x(bgArray[0, i], camX * bgArray[1, i]);
	
	i++;
	
}