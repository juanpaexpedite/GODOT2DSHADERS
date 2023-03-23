//Sin typical graph
//Grafica tipica del seno
shader_type canvas_item;
const float PI = 3.14159265358979323846;

uniform sampler2D noise;
uniform float impact = 0.0;
const float amplitude = 0.1;
const float peaks = 4.0;
const float velocity = -3.0;

void fragment() 
{	
	
	//float y = -1. * delta_ampl *sin (peaks*UV.x*2.*PI) + 0.5;
	
	float delta_impact_ampl = impact * sin(5.*TIME);
	float y = -1. * delta_impact_ampl *sin (UV.x*2.*PI-PI/2.) + 1.0;
	
	//NOISE:
	vec2 uv_noise = vec2(UV.x + sin(-0.2*TIME), 0);
	float val_noise = 0.5 * texture(noise,uv_noise).r - 0.2;
	y += val_noise;
	
	float delta_ampl = amplitude * sin(TIME);
	y += -1.* delta_ampl *sin(peaks*UV.x*2.*PI) - 0.5;
	
	if(UV.y > y)
	{
		COLOR = vec4(0,1,1,1);
	}
	else
	{
		COLOR = vec4(0,0,0,0);
	}
}