extends KinematicBody2D

onready var brain = get_node("Brain")

#Brain will tell us when to walk
func _ready():
	set_layer_mask(1)
	set_collision_mask(4)
	brain.connect("body_walk",self,"_on_body_walk")
	brain.connect("body_dash",self,"_on_body_dash")
	

func _on_body_walk(vec):
	move(vec)

func _on_body_dash(vec):
	move(vec)

func _on_area_enter(other):
	