extends Area2D

onready var mySprite = get_node("Sprite")
onready var mySpriteFrames = mySprite.get_sprite_frames()

func _ready():
	set_process(true)
	mySprite.connect("finished",self,"_on_anim_finish")
	pass
	
func _on_anim_finish():
	queue_free()
