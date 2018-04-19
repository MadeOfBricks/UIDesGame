extends KinematicBody2D

onready var main = get_parent()
onready var brain = get_node("Brain")
onready var health = 1

#Brain will tell us when to walk
func _ready():
	set_layer_mask(2)
	set_collision_mask(4)
	brain.connect("body_walk",self,"_on_body_walk")
	brain.connect("body_attack", self, "_on_body_attack")
	
#When we need to walk, set pos to new vector provided by brain
func _on_body_walk(vec):
	move(vec)

func _die():
	if false:
		var meInMain = main.enemies.find(self)
		main.enemies.remove(meInMain)
		
	main._remove_enemy(self)
	queue_free()

func _on_body_attack(vec,count):
	print("now we attack")
	
	

func _set_Attack_Speed(speed):
	brain.stormSpeed =speed
	
func _set_Turn_Speed(speed):
	brain.turnSpeed =speed