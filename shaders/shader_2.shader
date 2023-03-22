//Sin typical graph
//Grafica tipica del seno
shader_type canvas_item;
const float PI = 3.14159265358979323846;

const float amplitude = 0.3;

void fragment() 
{	
	float y = -1. *  amplitude *sin (UV.x*2.*PI) + 0.5;
	
	if(UV.y > y)
	{
		COLOR = vec4(0,1,1,1);
	}
	else
	{
		COLOR = vec4(0,0,0,0);
	}
}