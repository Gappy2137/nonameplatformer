if (enablePhy) {

	physics_world_create(1/32);
	physics_world_gravity(0, 9);
	physics_world_update_iterations(1);
	physics_world_update_speed(game_get_speed(gamespeed_fps));
	
}

var layers = layer_get_all();

// Background layer for parallax

bgArray[1][0] = .3;
bgArray[1][1] = .2;
bgArray[1][2] = .1;
bgArray[1][3] = .05;

var i = 0, j = 0;

repeat(array_length(layers)) {
	
	if (string_starts_with(layer_get_name(layers[i]), "Bg_")) {
	
		bgArray[0, j] = layer_get_name(layers[i]);
		
		j++;
	
	}
	
	i++;
	
}

// Wind

windStr = 7;
windDir = -1;

// Filter Effects

	// Waves
	/*
	var fxWaves = fx_create("_filter_underwater");
	fx_set_parameter(fxWaves, "g_Distort1Speed", .03);
	fx_set_parameter(fxWaves, "g_Distort2Speed", 0);
	fx_set_parameter(fxWaves, "g_Distort1Scale", 8);
	fx_set_parameter(fxWaves, "g_Distort2Scale", 1);
	fx_set_parameter(fxWaves, "g_Distort1Amount", 2);
	fx_set_parameter(fxWaves, "g_Distort2Amount", 0);
	fx_set_parameter(fxWaves, "g_ChromaSpreadAmount", 0);
	fx_set_parameter(fxWaves, "g_CamOffsetScale", 0);
	fx_set_parameter(fxWaves, "g_GlintCol", #000000);
	fx_set_parameter(fxWaves, "g_TintCol", [1, 1, 1, 0]);
	fx_set_parameter(fxWaves, "g_AddCol", #000000);
	
	i = 0;
	j = 0;

	repeat(array_length(layers)) {
		
		if (string_pos("Waving", layer_get_name(layers[i])) != 0) {
			
			layer_set_fx(layer_get_name(layers[i]), fxWaves);
			fx_set_single_layer(fxWaves, true);
			
		}
			
		i++;
	
	}
	*/
// test




// Particle system

	// Dust
	/*
	partDustColors[0] = #885041;
	partDustColors[1] = #583126;

	partDustSystem = part_system_create_layer(LAYER_INST, true);
	part_system_draw_order(partDustSystem, true);

	partDustType = part_type_create();
	part_type_sprite(partDustType, spr_dust_part, false, false, false)
	part_type_size(partDustType, 0.5, 1.5, -0.1, 0);
	part_type_scale(partDustType, 1, 1);
	part_type_speed(partDustType, 1, 1, 0, 0);
	part_type_direction(partDustType, 0, 180, 0, 0);
	part_type_gravity(partDustType, 0.1, 270);
	part_type_orientation(partDustType, 0, 180, 0, 3, false);
	part_type_colour1(partDustType, partDustColors[irandom_range(0, array_length(partDustColors) - 1)]);
	part_type_alpha3(partDustType, 1, 1, 1);
	part_type_blend(partDustType, false);
	part_type_life(partDustType, 8, 16);

	partDustEmitter = part_emitter_create(partDustSystem);
	part_emitter_region(partDustSystem, partDustEmitter, -8, 8, -1, 1, ps_shape_ellipse, ps_distr_gaussian);
	//part_emitter_burst(partSystem, partDustEmitter, partDustType, 8);
*/
	//part_system_position(_ps, room_width/2, room_height/2);


// Camera borders

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