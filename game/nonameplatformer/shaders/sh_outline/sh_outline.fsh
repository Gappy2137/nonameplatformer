//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texel;
uniform vec4 color;
uniform float thickness;

void main()
{
	
	vec4 final = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec2 size = texel * thickness;
	
	if ( texture2D( gm_BaseTexture, v_vTexcoord ).a <= 0.0 )
	{
	
		float alpha = 0.0;
		
		alpha += max(alpha, texture2D( gm_BaseTexture, vec2(v_vTexcoord.x - size.x, v_vTexcoord.y)).a );
		alpha += max(alpha, texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + size.x, v_vTexcoord.y)).a );
		alpha += max(alpha, texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - size.y)).a );
		alpha += max(alpha, texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + size.y)).a );
	
		if (alpha > 0.0)
		{
		
			final = color;
		
		}
	
	}
	
    gl_FragColor = final;
}
