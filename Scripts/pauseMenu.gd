extends Node2D

onready var main = get_parent()

func _ready():
	get_node("VBoxContainer/Label").set_text("1st ----- %d pts" % global.scores[0])
	get_node("VBoxContainer/Label 2").set_text("2nd ----- %d pts" % global.scores[1])
	get_node("VBoxContainer/Label 3").set_text("3rd ----- %d pts" % global.scores[2])
	get_node("VBoxContainer/Label 4").set_text("4th ----- %d pts" % global.scores[3])
	get_node("VBoxContainer/Label 5").set_text("5th ----- %d pts" % global.scores[4])
	get_node("VBoxContainer 2/Label").set_text("6th ----- %d pts" % global.scores[5])
	get_node("VBoxContainer 2/Label 2").set_text("7th ----- %d pts" % global.scores[6])
	get_node("VBoxContainer 2/Label 3").set_text("8th ----- %d pts" % global.scores[7])
	get_node("VBoxContainer 2/Label 4").set_text("9th ----- %d pts" % global.scores[8])
	get_node("VBoxContainer 2/Label 5").set_text("10th ----- %d pts" % global.scores[9])
	
	get_node("Label 3").set_text("Your current score: %d pts" % global.pScore)

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
	pData["eAtkSpd"] = global.enemyAttackSpeed
	pData["eTurnSpd"] = global.enemyTurnSpeed
	#global.enemyNumber -= 1
	pData["eNum"] = global.enemyNumber
	global.firstLoad = true
	
	var file = File.new()
	file.open_encrypted_with_pass("user://savegame.bin", File.WRITE, OS.get_unique_ID())
	file.store_line(pData.to_json())
	file.close()
	
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
	get_tree().set_pause(false)
