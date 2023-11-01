if (enablePhy) {

	physics_world_create(1/32);
	physics_world_gravity(0, 9);
	physics_world_update_iterations(1);
	physics_world_update_speed(game_get_speed(gamespeed_fps));
	
}

// Background layer for parallax

bgArray[1][0] = .3;
bgArray[1][1] = .2;
bgArray[1][2] = .1;
bgArray[1][3] = .05;

var layers = layer_get_all();
var i = 0, j = 0;

repeat(array_length(layers)) {
	
	if (string_starts_with(layer_get_name(layers[i]), "Bg_")) {
	
		bgArray[0, j] = layer_get_name(layers[i]);
		
		j++;
	
	}
	
	i++;
	
}

areaArray = [];


i = 0;

repeat(instance_number(obj_cameraborder_8)) {

	var area = instance_find(obj_cameraborder_8, i);
	
	area.area = i + 1;
	
	areaArray[i][0] = area.area;
	areaArray[i][1] = area.x;
	areaArray[i][2] = area.y;
	areaArray[i][3] = area.image_xscale * 8;
	areaArray[i][4] = area.image_yscale * 8;
	
	i++;

}