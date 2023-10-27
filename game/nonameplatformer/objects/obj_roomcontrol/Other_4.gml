
var i = 0;

repeat(instance_number(obj_cameraborder_8)) {

	var area = instance_find(obj_cameraborder_8, i);
	
	areaArray[i][0] = area.num;
	areaArray[i][1] = area.x;
	areaArray[i][2] = area.y;
	areaArray[i][3] = area.image_xscale * 8;
	areaArray[i][4] = area.image_yscale * 8;
	
	i++;

}