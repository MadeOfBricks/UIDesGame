extends Area2D

onready var brain = get_node("Brain")

#Brain will tell us when to walk
func _ready():
	brain.connect("body_walk",self,"_on_body_walk")

#When we need to walk, set pos to new vector provided by brain
func _on_body_walk(vec):
	set_pos(get_pos() + vec)