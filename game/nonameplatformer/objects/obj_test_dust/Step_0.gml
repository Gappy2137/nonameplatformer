	
		switch (type) {
		
			case 0:
			
				//size -= randomDec * .25;
				angle += randomDec * 50 * randomDir;
				//alpha -= randomDec * .75;
		
				grav += .01;
				
				hsp = lengthdir_x(spd, dir);
				vsp = (lengthdir_y(spd, dir) * .75) + grav;
		
				//xx += hsp;
				//yy += vsp;
			
			break;
			
			case 1:
			
				size += randomDec * .35;
				alpha -= randomDec * .25;
			
			break;
			
			case 2:
			
				angle += randomDec * 100 * randomDir;
				alpha -= .011;
		
				grav += .02;
				fric += .02;
				
				//grav = clamp(grav, 0, .5);
				//fric = clamp(fric, 0, .5);
		
				hsp = lerp(lengthdir_x(spd, dir), 0, fric);
				vsp = lerp(lengthdir_y(spd, dir), 0, grav);
				
				xx += hsp;
				yy += vsp;
			
			break;
		
		}
	