extends KinematicBody2D

onready var brain = get_node("Brain")
onready var hitDetector = get_node("HitDetector")
onready var health = 3

#Brain will tell us when to walk
func _ready():
	set_layer_mask(1)
	hitDetector.set_collision_mask(8)
	set_collision_mask(4)
	brain.connect("body_walk",self,"_on_body_walk")
	brain.connect("body_dash",self,"_on_body_dash")
	hitDetector.connect("body_enter",self,"_on_body_enter")
	

func _on_body_walk(vec):
	move(vec)

func _on_body_dash(vec):
	move(vec)

func _on_body_enter(other):
	print(other.get_name())
	if other.is_in_group("enemyProjectiles"):
		health -= 1
		print(health)