extends RigidBody2D


func _ready():
	set_layer_mask(4)
	set_collision_mask(1)
	set_collision_mask(2)
