extends KinematicBody2D

onready var brain = get_node("Brain")

#Brain will tell us when to walk
func _ready():
	brain.connect("body_walk",self,"_on_body_walk")
	

func _on_body_walk(vec):
	move(vec)

func _on_area_enter(other):
	