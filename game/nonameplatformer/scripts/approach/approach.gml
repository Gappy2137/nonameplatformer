function approach(start, target, rate){

	if start > target {
	    return max(start - rate, target);
	}
	else if start < target {
	    return min(start + rate, target);
	}
	else return target;

}