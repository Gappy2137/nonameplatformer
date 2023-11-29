
draw_sprite(spr_inv_bg, 0, GUIselX - 8, GUIselY);

var i = 0;
var l = (array_length(dsInv) * 4) - 1;

repeat(l) {
	
	draw_sprite(spr_inv_bg, 1, GUIselX + (i * 8), GUIselY);
	if (i == l - 1)
		draw_sprite(spr_inv_bg, 2, GUIselX + (i * 8) + 8, GUIselY);	
	
	++i;
	
}

i = 0;

repeat(array_length(dsInv)) {
	
	var alpha = (equipped == i) ? 1 : 0.1;
gpu_set_blendmode(bm_add);
	draw_sprite_ext(selSprite, 0, GUIselX + (i * GUIselWidth) + (i * 8), GUIselY, 1, 1, 0, #FFFFFF, alpha);
	gpu_set_blendmode(bm_normal);
	//gpu_set_blendmode(bm_add);
	
	draw_sprite_ext(selSprite, i + 1, GUIselX + (i * GUIselWidth) + (i * 8), GUIselY, 1, 1, 0, #FFFFFF, alpha + .1);

	//gpu_set_blendmode(bm_normal);
	
	++i;

}