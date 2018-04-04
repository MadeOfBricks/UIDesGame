extends Timer
var count = 0;
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    connect("timeout",self,"_on_timeout")
func _on_timeout():
	if (count >= 1):
		print(count)
		get_node("../Label").set_text("%d" % count)
		count = count-1;
	elif (count <= 0 and count >= -1):
		get_node("../Label").set_text("Go!")
		count = count - 1;
	else:
		get_node("../Label").set_text("")