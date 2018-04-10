extends SamplePlayer
onready var nCount = get_node("../Timer")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func playSound():
	play("countdown")