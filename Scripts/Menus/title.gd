extends VBoxContainer

onready var global = get_tree().get_root().get_node("/root/global")

func _ready():
	randomize()

func _on_Play_released():
	var file = File.new()
	if not file.file_exists("user://savegame.bin"):
		get_tree().change_scene("res://Scenes/characterSelect.tscn")
	else:
		
		get_tree().change_scene("res://Scenes/mainGame.tscn")


func _on_Training_released():
	get_tree().change_scene("res://Scenes/trainingScreen.tscn")


func _on_Options_released():
	get_tree().change_scene("res://Scenes/optionsScreen.tscn")


func _on_Play_pressed():
	get_node("../Loading").set_text("Loading...")
