function newParticle(xx, yy, spr, color, img, type){

	var part = new obj_game.particleFX(xx, yy, spr, color, img, type);
	
	array_push(obj_particlesystem.drawArray, part);

}