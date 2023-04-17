shader_type canvas_item;
render_mode unshaded, blend_disabled;

uniform float angle_degrees = 0.0;
uniform float pivot_x = 1.0;
uniform float pivot_y = 0.5;
uniform float pixelSize = 1.1;
const float PI = 3.14159265358979323846;
const float degtorad = PI/180.0;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}

void fragment() {
	
	vec2 nearestPixelUV = (TEXTURE_PIXEL_SIZE*pixelSize) * round(UV / (TEXTURE_PIXEL_SIZE*pixelSize));
    COLOR = texture(TEXTURE, nearestPixelUV);
	
	vec2 rotated_pos = rotateUV(nearestPixelUV,vec2(pivot_x*TEXTURE_PIXEL_SIZE.x,pivot_y*TEXTURE_PIXEL_SIZE.y), angle_degrees*degtorad);

	
	if (rotated_pos.x < 0.0 || rotated_pos.x > 1.0 || rotated_pos.y > 1.0 || rotated_pos.y < 0.0)
	{
		COLOR = vec4(0,0,0,0);	
	}
	else
	{
	    COLOR = texture(TEXTURE, rotated_pos );
	}
}