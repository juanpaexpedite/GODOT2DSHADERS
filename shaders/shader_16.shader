//Sin typical graph
//Grafica tipica del seno
shader_type canvas_item;
const float PI = 3.14159265358979323846;

const float pixelation_x = 256.0;
const float pixelation_y = 128.0;
uniform vec4 line_color : hint_color = vec4(1,1,1,0.8);
uniform vec4 water_color : hint_color = vec4(0,0,1,0.8);
uniform sampler2D water_gradient;
uniform sampler2D noise;
uniform sampler2D distort;
uniform float impact = 0.0;
const float amplitude = 0.1;
const float peaks = 4.0;
const float velocity = -3.0;



void fragment() 
{	
	//pixelate
	float uvpx = round(UV.x * pixelation_x) / pixelation_x;
	float uvpy = round(UV.y * pixelation_y) / pixelation_y;
	
	//IMPACT
	float delta_impact_ampl = impact * sin(5.*TIME);
	float y = -1. * delta_impact_ampl *sin (UV.x*2.*PI-PI/2.);
	
	//NOISE:
	float uvx_noise = uvpx * sin(-0.3*TIME);
	vec2 uv_noise = vec2(uvx_noise, 0);
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
		//TESTING
		vec2 text_size = TEXTURE_PIXEL_SIZE;
		vec2 fragmentCenterPixelCoordinates = UV / TEXTURE_PIXEL_SIZE;
		vec2 res = (1.0/SCREEN_PIXEL_SIZE);
		vec2 st = FRAGCOORD.xy/res;
		
		//TO AVOID THE MAGIC NUMBERS I HAVE TO FIND OUT THE SIZE OF THE SHADER...
		
		//								MAGIC NUMBER
		vec2 screen_pos = SCREEN_UV + vec2(0.0,-0.03);
		vec2 offset = vec2(0.1*TIME,0.1*TIME);
		vec4 noiseColor = texture(noise,screen_pos+offset);
		vec4 distortColor = texture(distort,screen_pos+offset);
		float offset_x = 0.1*noiseColor.r;
		float offset_y = 0.1*distortColor.r;
		
		float nx = screen_pos.x + 0.5*sin(offset_x);
		
		float ny = screen_pos.y + 0.5*sin(offset_y);
		
		//MAGIC NUMBER
		if(UV.x > 0.8)
		{
			nx -= 0.1;
		}
		
		//MAGIC NUMBER
		if(UV.y > 0.95)
		{
			ny += 0.1;
		}
		
		float npx = round(nx * 320.) / 320.;
		float npy = round(ny * 256.) / 256.;
		
		
		
		//vec4 screen_color = textureLod(SCREEN_TEXTURE,SCREEN_UV,0.0);
		vec4 screen_color = textureLod(SCREEN_TEXTURE,vec2(npx,npy),0.0).rgba;

		//vec2 screen_size = SCREEN_PIXEL_SIZE;
		//vec2 pixel_pos = FRAGCOORD.xy;
		
		
		vec2 grad_pos = vec2(uvpx,uvpy);
		vec4 gradient_color = texture(water_gradient,grad_pos);

		COLOR = mix(screen_color,gradient_color,0.4);
	}
	else
	{
		COLOR = vec4(0,0,0,0);
	}
}

