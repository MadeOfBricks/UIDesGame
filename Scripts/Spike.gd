extends Area2D

onready var Velocity = Vector2(20,20)

func _ready():
	set_collision_mask(1)
	set_layer_mask(8)
	set_collision_mask(4)
	set_process(true)
	pass

func _process(delta):
	set_pos(get_pos() + (Velocity * delta))