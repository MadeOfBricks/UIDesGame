extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("frame_changed", self, "_on_frame_change")

func _on_frame_change():
	set_modulate(Color(.2,.2,.2)) 
