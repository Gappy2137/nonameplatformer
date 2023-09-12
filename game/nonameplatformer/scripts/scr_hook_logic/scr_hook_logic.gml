function scr_hook_logic() {

	if (!instance_exists(obj_player)) exit;

	var keyLaunch =			mouse_check_button_pressed(mb_left);
	var keyRelease =		mouse_check_button_pressed(mb_right);
	
	switch (state) {
	
		case hookState.onPlayer:
		
			hsp = 0;
			vsp = 0;
			catchTime = 0;
			launchTime = 0;
			hookPullEnd = false;
			ropeImpulse = 0;
			ropeID = noone;
			
			angleToMouse = point_direction(x, y, global.game.mouseXR, global.game.mouseYR);
			
			if ( (keyLaunch) && (canUse) ) {
	
				launchAngle = angleToMouse;
				
				state = hookState.launched;
				
				var ray = raycast(x, y, x + lengthdir_x(maxRange + obj_player.hsp, angleToMouse), y + lengthdir_y(maxRange + obj_player.vsp, angleToMouse), par_solid, [par_semisolid]);
				
				if (ray[0] != noone) {
					
					if (object_is_ancestor(ray[0].object_index, par_solid)) {
					
						if (ray[0].canBeAttachedTo)
						&& (ray[0].canCollide)
						&& (!ray[0].semiSolid) {
					
							embeddedTo = ray[0];
							anchorX = ray[1];
							anchorY = ray[2];
							
					
						}
					
					}
					
				}
	
			}
			
			hookAngle = angleToMouse;
		
		break;
		case hookState.launched:
		
			launchTime++;
			catchTime = 0;
			
			if (launchTime > launchTimeMax)
			|| (keyRelease) {
			
				state = hookState.released;
			
			}
			
			hookAngle = launchAngle;
			
			hsp = lengthdir_x(launchSpd, launchAngle);
			vsp = lengthdir_y(launchSpd, launchAngle);
			
			if (embeddedTo != noone) {
				
				x = anchorX;
				y = anchorY;
		
				var distance = point_distance(drawX, drawY, anchorX, anchorY);
				var velocity = sqrt(sqr(hsp) + sqr(vsp));
			
				timeToEmbed = distance / velocity;
			
				drawX = lerp(drawX, anchorX, .5);
				drawY = lerp(drawY, anchorY, .5);
			
				if (embedTimer >= timeToEmbed) {
			
					embedTimer = 0;
					timeToEmbed = 0;
					state = hookState.embedded;
			
				} else {
				
					embedTimer++;
				
				}
			
			} else {
			
				drawX += hsp;
				drawY += vsp;
				
				//var _rangeX = (maxRange / 2) * sign(hsp);
				//var _rangeY = (maxRange / 2) * sign(vsp);
				
				var distance = point_distance(x, y, drawX, drawY);
				//var maxDistance = point_distance(x, y, x + maxRange, y + maxRange);
				
				if (distance > maxRange - spdBase)
					state = hookState.released;
			}
	

			
		break;
		case hookState.released:
		
			if (ropeID != noone) {
				
				instance_destroy(ropeID);
				ropeID = noone;
				
			}
		
			ropeImpulse = 0;
		
			launchTime = 0;
			catchTime++;
			
			embeddedTo = noone;
			anchorX = -1;
			anchorY = -1;
			
			obj_player.offHookTrigger = true;
		
			var returnTo = obj_player;
			//var returnToX = returnTo.x;
			//var returnToY = returnTo.y;
			
			if (collision_circle(drawX, drawY, 12, returnTo, true, false))
			|| (catchTime >= catchTimeMax) {
			
				state = hookState.onPlayer;
				catchTime = 0;
			
			}
			
			hookAngle = point_direction(drawX, drawY, returnTo.x, returnTo.y) + 180;
			drawX = lerp(drawX, returnTo.x, .25);
			drawY = lerp(drawY, returnTo.y, .25);
			
			x = returnTo.x;
			y = returnTo.y;
			
			/*
			var angleReturn = point_direction(x, y, returnToX, returnToY);

			hsp = lengthdir_x(releaseSpd, angleReturn);
			vsp = lengthdir_y(releaseSpd, angleReturn);
	
			x += hsp;
			y += vsp;
			drawX = x;
			drawY = y;
			
			*/
		break;
		case hookState.embedded:
		
			if (!ropeImpulse)
				ropeImpulse = 1;
			
			if (ropeImpulse == 1) {
			
				var aX = anchorX;
				var aY = anchorY;
			
				ropeID = instance_create_layer(aX, aY, LAYER_INST, obj_testrope_hold);
				
				with (ropeID) {
				
					anchorX = aX;
					anchorY = aY;
					
				}
				
				ropeImpulse = 2;
			
			}
		
			if (embeddedTo != noone) {
				
				x = anchorX;
				y = anchorY;
				drawX = x;
				drawY = y;
			
			}
		
			catchTime = 0;
			launchTime = 0;
		
			if (keyRelease)
				state = hookState.released;
			
			hsp = 0;
			vsp = 0;
		
		break;
		
	}
	
}