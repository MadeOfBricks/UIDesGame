extends VBoxContainer
onready var Quit = get_node("Quit")

func _ready():
	Quit.connect("released",self,"_on_quit_released")
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
	if Quit.is_connected("released",self,"_on_quit_released"):
		print("Quit connected")
	else:
		print("Quit not connected")
	

func _on_quit_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")


func _on_Quit_released():
	print("COME ON")
