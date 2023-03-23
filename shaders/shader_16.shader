//Sin typical graph
//Grafica tipica del seno
shader_type canvas_item;
const float PI = 3.14159265358979323846;

uniform float pixelation_x = 128;
uniform float pixelation_y = 64;
uniform vec4 line_color : hint_color = vec4(1,1,1,0.8);
uniform vec4 water_color : hint_color = vec4(0,0,1,0.8);
uniform sampler2D water_gradient;
uniform sampler2D noise;
uniform float impact = 0.0;
const float amplitude = 0.1;
const float peaks = 4.0;
const float velocity = -3.0;

void fragment() 
{	
	//pixelate
	float uvpx = round(UV.x * pixelation_x) / pixelation_x;
	float uvpy = round(UV.y * pixelation_y) / pixelation_y;
	
	//float y = -1. * delta_ampl *sin (peaks*UV.x*2.*PI) + 0.5;
	
	float delta_impact_ampl = impact * sin(5.*TIME);
	float y = -1. * delta_impact_ampl *sin (uvpx*2.*PI-PI/2.);
	
	//NOISE:
	float uvpx_noise = round((uvpx + sin(-0.05*TIME)) * pixelation_x) / pixelation_x;
	vec2 uv_noise = vec2(uvpx_noise, 0);
	float val_noise = 0.5 * texture(noise,uv_noise).r;
	y += val_noise;
	
	float delta_ampl = amplitude * sin(TIME);
	y += -1.* delta_ampl *sin(peaks*uvpx*2.*PI) + 0.25;
	
	float dif = uvpy - y;
	if(abs(dif) < 0.01)
	{
		COLOR = line_color;
	}
	else if(dif > 0.01)
	{	
		vec2 screen_pos = SCREEN_UV + vec2(0.01*texture(noise,uv_noise).r, 0.5*texture(noise,uv_noise).r);
		vec4 c = textureLod(SCREEN_TEXTURE, screen_pos, 0.0);

		vec2 grad_pos = vec2(uvpx,uvpy);
		vec4 t = texture(water_gradient,grad_pos);

		COLOR = mix(c,t,0.3);
		
	}
	else
	{
		COLOR = vec4(0,0,0,0);
	}
}