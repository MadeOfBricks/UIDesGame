extends Node

onready var main = get_parent()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

var pData = {}

func _on_Continue_released():
	queue_free()
	get_tree().set_pause(false)


func _on_Quit_released():
	queue_free()
	
	var file = File.new()
	file.open("res://Packed/saveFile.sav", File.READ)
	var text = file.get_as_text()
	pData.parse_json(text)
	file.close()
	
	var dir = Directory.new()
	dir.remove("res://Packed/saveFile.sav")
	pData["pScore"] = 0
	#pData["pScore"] = main.score
	
	var file = File.new()
	file.open("res://Packed/saveFile.sav", File.WRITE) 
	file.store_line(pData.to_json())
	file.close()
	
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
	get_tree().set_pause(false)
