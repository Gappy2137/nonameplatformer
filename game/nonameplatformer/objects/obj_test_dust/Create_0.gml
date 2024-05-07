xx = 100;
yy = 100;
sprite = spr_dust_part;
color = #FFFFFF;
image = 3;
type = 0;
	
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
	