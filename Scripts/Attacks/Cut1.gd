extends Area2D

onready var mySprite = get_node("Sprite")
onready var mySpriteFrames = mySprite.get_sprite_frames()

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if mySprite.get_frame() >= mySpriteFrames.get_frame_count("Cut1"):
		queue_free();
