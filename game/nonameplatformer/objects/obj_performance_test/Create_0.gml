var amount = 1000;

if (room == rm_performance) {

	repeat(amount){
		newParticle(100, 100, spr_dust_part, #885041, 3, 0);
	}
}

if (room == rm_performance_1) {

	repeat(amount){
		instance_create_layer(100, 100, "Instances", obj_test_dust);
	}
}

filename = working_directory + "perf1.txt";

file = file_text_open_append(filename);

