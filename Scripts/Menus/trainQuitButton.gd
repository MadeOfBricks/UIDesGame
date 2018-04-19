extends TextureButton

func _ready():
	connect("released",self,"_on_released")
	if is_connected("released",self,"_on_released"):
		print("connected")

func _on_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
