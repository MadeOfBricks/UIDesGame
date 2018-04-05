extends Node2D
var gameState = true
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var file = File.new()
	file.open("res://Packed/saveFile.txt", File.READ)
	var colorPath = file.get_as_text()
	file.close()
	get_node("PlayerBody/Sprite").set = get_node(colorPath)
	set_process(true)

func _process(delta):
	pass

func _on_Pause_released():
	var item = preload("res://Packed/pauseMenu.tscn").instance()
	get_parent().add_child(item)