//Sin typical graph
//Grafica tipica del seno
shader_type canvas_item;
const float PI = 3.14159265358979323846;

const float amplitude = 0.3;
const float peaks = 2.0;

void fragment() 
{	
	float delta_ampl = amplitude * sin(TIME);
	float y = -1. * delta_ampl *sin (peaks*UV.x*2.*PI-PI/2.) + 0.5;
	
	if(UV.y > y)
	{
		COLOR = vec4(0,1,1,1);
	}
	else
	{
		COLOR = vec4(0,0,0,0);
	}
}