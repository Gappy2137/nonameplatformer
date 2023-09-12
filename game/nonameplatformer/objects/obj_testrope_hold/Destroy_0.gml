var i = 0;

repeat(array_length(jointArray)) {
	
	physics_joint_delete(i);
	jointArray[i] = 0;
	
	i++;

}

i = 0;



repeat(array_length(ropeArray)) {

	with(ropeArray[i]) {
		
		joint = 0;
		instance_destroy();
		
	}
	
	i++;

}