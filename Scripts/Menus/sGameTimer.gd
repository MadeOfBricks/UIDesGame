extends Timer
var count = 0;

onready var gameLabel = get_node("../Label")

func isCount():
	return count

func _ready():
	connect("timeout",self,"_on_timeout")
	gameLabel.set_text("Go!")

func _on_timeout():
	if count == -1:
		gameLabel.set_text("")