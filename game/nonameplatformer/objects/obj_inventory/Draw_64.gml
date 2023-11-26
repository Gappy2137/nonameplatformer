
var i = 0;

repeat(array_length(dsInv)) {
	
	var alpha = (equipped == i) ? 1 : 0.1;

	draw_sprite_ext(selSprite, 0, GUIselX + (i * GUIselWidth) + (i * 8), GUIselY, 1, 1, 0, #FFFFFF, alpha);
	
	draw_sprite_ext(selSprite, i + 1, GUIselX + (i * GUIselWidth) + (i * 8), GUIselY, 1, 1, 0, #FFFFFF, alpha);


	++i;

}