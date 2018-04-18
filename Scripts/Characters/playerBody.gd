extends KinematicBody2D

onready var brain = get_node("Brain")
onready var global = get_tree().get_root().get_node("/root/global")

onready var hitDetector = get_node("HitDetector")

var HealthCo = [[1,0,0],[1,1,0],[0,1,0]]

#Brain will tell us when to walk
func _ready():
	get_node("../HealthBar").set_frame_color(Color(HealthCo[global.pHealth-1][0], HealthCo[global.pHealth-1][1], HealthCo[global.pHealth-1 - 1][2]))
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


func _on_HitDetector_area_enter( area ):
	if area.is_in_group("enemyProjectiles")&& brain.currentAction != "dashTowards":
		var vec = Vector2((get_node("../HealthBar").get_size().x - 50), 17)
		get_node("../HealthBar").set_size(vec)
		get_node("../HealthBar").set_frame_color(Color(HealthCo[global.pHealth-2][0], HealthCo[global.pHealth-2][1], HealthCo[global.pHealth - 2][2]))
		area.queue_free()
		global.pHealth -= 1
		print("ouch")
		if global.pHealth <= 0:
			_die()
			


func _die():
	queue_free()
	global.enemyNumber = 0
