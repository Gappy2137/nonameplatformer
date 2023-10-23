function bezier_points(t, p0, p1, p2, p3){

	var u = 1 - t;
	var tt = t*t;
	var uu = u*u;
	var uuu = uu * u;
	var ttt = tt * t;

	var p = [uuu * p0[0], uuu * p0[1]];
	p[0] += 3 * uu * t * p1[0];
	p[0] += 3 * u * tt * p2[0];
	p[0] += ttt * p3[0];
	p[1] += 3 * uu * t * p1[1];
	p[1] += 3 * u * tt * p2[1];
	p[1] += ttt * p3[1];
	
	
	return p;

}