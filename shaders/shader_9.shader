//Sin typical graph
//Grafica tipica del seno
shader_type canvas_item;
const float PI = 3.14159265358979323846;

uniform float impact = 0.0;
const float amplitude = 0.1;
const float peaks = 4.0;


void fragment() 
{	
	
	//float y = -1. * delta_ampl *sin (peaks*UV.x*2.*PI) + 0.5;
	
	float delta_impact_ampl = impact * sin(5.*TIME);
	float y = -1. * delta_impact_ampl *sin (UV.x*2.*PI-PI/2.) + 1.0;
	
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