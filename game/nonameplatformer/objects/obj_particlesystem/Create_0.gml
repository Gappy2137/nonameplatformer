depth = 0;

// Particle system based on constructors
// If _image is set to -1 it picks random subimage from _spr
// Type: 0 - particle goes in random direction with gravity - landing dust
// Type: 1 - stationary particle, grows and disappears - jump orb halo
// Type: 2 - particle goes in random direction with gravity (1 size) - shards

function particleFX(_x, _y, _spr, _color, _image, _type) constructor {
	
	xx = _x;
	yy = _y;
	sprite = _spr;
	color = _color;
	image = (_image == -1 ? irandom(_image) : _image);
	type = _type;
	
	alpha = 1;
	randomDec = round_to_2(random_range(.025, .2));
	randomDir = choose(-1, 1);
	grav = .1;
	fric = .1;
	
	hsp = 0;
	vsp = 0;
	
	switch (type) {
		case 0:
		
			dir = irandom_range(0, 180); 
			size = random_range(.5, 1.25);
			spd = random_range(.5, .75);
			angle = irandom(359);
			
		break;
		
		case 1:
		
			dir = 0;
			size = .5;
			spd = 0;
			angle = 0;
			
		break;
		
		case 2:
		
			dir = irandom_range(0, 359);
			size = 1;
			spd = random_range(.75, 1);
			angle = irandom(359);
			
		break;
	}
	
	Step = function() {
	
		switch (type) {
		
			case 0:
			
				size -= randomDec * .25;
				angle += randomDec * 50 * randomDir;
				alpha -= randomDec * .75;
		
				grav += .01;
				
				hsp = lengthdir_x(spd, dir);
				vsp = (lengthdir_y(spd, dir) * .75) + grav;
		
				xx += hsp;
				yy += vsp;
			
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
	
	}
	
	Draw = function() {
		
		draw_sprite_ext(sprite, image, xx, yy, size, size, angle, color, alpha);
		
	}
	
}

drawArray = [];