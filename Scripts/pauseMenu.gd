extends Node2D

onready var main = get_parent()

func _ready():
	pass

var pData = {}

func _on_Continue_released():
	queue_free()
	get_tree().set_pause(false)


func _on_Quit_released():
	queue_free()
	
	var file = File.new()	
	var dir = Directory.new()
	dir.remove("user://savegame.bin")
	
	pData["pScore"] = global.pScore
	pData["pHealth"] = global.pHealth
	pData["pColor"] = global.pColor
	#global.enemyNumber -= 1
	pData["eNum"] = global.enemyNumber
	global.firstLoad = true
	
	var file = File.new()
	file.open_encrypted_with_pass("user://savegame.bin", File.WRITE, OS.get_unique_ID())
	file.store_line(pData.to_json())
	file.close()
	
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
	get_tree().set_pause(false)
