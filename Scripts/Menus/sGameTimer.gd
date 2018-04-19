extends Timer
var count = 0;

onready var gameLabel = get_node("../Label")

func isCount():
	return count
var blink = false

func _ready():
	connect("timeout",self,"_on_timeout")
	gameLabel.set_text("Go!")

func _on_timeout():
	if count == -1:
		gameLabel.set_text("")
	if blink == false:
		get_node("../Right").hide()
		get_node("../Left").hide()
		get_node("../Bottom").hide()
		get_node("../Up").hide()
		blink = true
	else:
		get_node("../Right").show()
		get_node("../Left").show()
		get_node("../Bottom").show()
		get_node("../Up").show()
		blink = false