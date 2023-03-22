extends Node2D

onready var sprite__256_x_128 = $Sprite_256x128

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var impact = 0.0
var max_impact = 0.5

func _input(event):
	if event.is_action_pressed("impact"):
		impact = max_impact

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite__256_x_128.material.set_shader_param("impact", impact)
	
	impact -= 0.002;
	impact = max(0.0,impact)
	
	pass
