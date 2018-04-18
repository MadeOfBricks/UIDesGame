extends Area2D

onready var main = get_tree().get_root()
onready var owner = get_parent()
onready var mySprite = get_node("Sprite")
onready var mySpriteFrames = mySprite.get_sprite_frames()
onready var mySpriteFramesCount = mySpriteFrames.get_frame_count("Cut1")

func _ready():
	set_process(true)
	mySprite.connect("finished",self,"_on_anim_finish")
	connect("body_enter",self,"_on_body_enter")
	pass

func _process(delta):
	if mySprite.get_frame() > 3:
		if !is_connected("body_enter",self,"_on_body_enter"):
			connect("body_enter",self,"_on_body_enter")
			print(get_name() + "connected")

func _on_anim_finish():
	queue_free()

func _on_body_enter(other):
	if other.get_name() != "PlayerBody" && other.is_in_group("enemies"):
		other.health -= 1
		if other.health <= 0:
			other._die()