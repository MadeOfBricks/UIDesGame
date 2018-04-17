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



func _on_HitDetector_body_enter( body ):
	print("fucking something")
	if body.is_in_group("enemyProjectiles"):
		health -= 1
		print(health)


func _on_HitDetector_area_enter( area ):
	if area.is_in_group("enemyProjectiles"):
		area.queue_free()
		health -= 1
		print("ouch")
		if health <= 0:
			_die()


func _die():
	queue_free()
