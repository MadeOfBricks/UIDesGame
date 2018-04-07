extends KinematicBody2D

onready var brain = get_node("Brain")
onready var health = 1

#Brain will tell us when to walk
func _ready():
	add_to_group("enemies")
	brain.connect("body_walk",self,"_on_body_walk")
	
#When we need to walk, set pos to new vector provided by brain
func _on_body_walk(vec):
	set_pos(get_pos() + vec)

func _die():
	queue_free()
