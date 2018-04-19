extends Area2D

var velocity = Vector2(20,20)

func _ready():
	set_collision_mask(1)
	set_layer_mask(8)
	set_collision_mask(4)
	set_process(true)
	
	connect("body_enter",self,"_on_body_enter")
	

func _process(delta):
	set_pos(get_pos() + (velocity))