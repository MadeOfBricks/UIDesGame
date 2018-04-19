extends KinematicBody2D

onready var main = get_parent()
onready var brain = get_node("Brain")
onready var mySprite = get_node("Sprite")
onready var health = 1

#Brain will tell us when to walk
func _ready():
	set_layer_mask(2)
	set_collision_mask(4)
	brain.connect("body_walk",self,"_on_body_walk")
	brain.connect("body_attack",self,"_on_body_attack")
	
#When we need to walk, set pos to new vector provided by brain
func _on_body_walk(vec):
	move(vec)

func _die():
	main._remove_enemy(self)
	var corpse = preload("res://Packed/enemyCorpse.tscn").instance()
	corpse.set_sprite_frames(mySprite.get_sprite_frames())
	corpse.set_animation("dead")
	corpse.set_pos(get_pos())
	corpse.set_scale(get_scale())
	main.add_child(corpse)
	queue_free()
	
func _on_body_attack(vec,count):
	print("now we attack")

