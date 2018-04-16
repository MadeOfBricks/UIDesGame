extends KinematicBody2D

onready var main = get_parent()
onready var brain = get_node("Brain")
onready var health = 1

#Brain will tell us when to walk
func _ready():
	set_layer_mask(2)
	set_collision_mask(4)
	add_to_group("enemies")
	brain.connect("body_walk",self,"_on_body_walk")
	
#When we need to walk, set pos to new vector provided by brain
func _on_body_walk(vec):
	move(vec)

func _die():
	var meInMain = main.enemies.find(self)
	main.enemies.remove(meInMain)
	queue_free()
