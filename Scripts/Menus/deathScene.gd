extends Node

onready var playerSprites = [
	preload("res://Sprites/Reapy_0.png"),
	preload("res://Sprites/ReapyR_0.png"),
	preload("res://Sprites/ReapyG_0.png"),
	preload("res://Sprites/ReapyB_0.png")
]
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var highScores = { "highScore" : 0 }
func _ready():
	highScores["highScore"] = global.pScore
	get_node("Score").set_text("You Scored: %d pts" % global.pScore)
	
	if global.pScore == 0:
		pass
	elif global.pScore < 300:
		get_node("Quote").set_text("Better luck next time!")
	elif global.pScore < 1000:
		get_node("Quote").set_text("Getting There!")
	elif global.pScore < 2000:
		get_node("Quote").set_text("Spectacular!")
	elif global.pScore < 10000:
		get_node("Quote").set_text("I don't think you could've done any better!")
	else:
		get_node("Quote").set_text("Speckled Void Champ!")
	
	get_node("ghost").set_texture(playerSprites[global.pColor])
	
	var file = File.new()
	file.open_encrypted_with_pass("user://highScores.bin", File.WRITE, OS.get_unique_ID())
	file.store_line(highScores.to_json())
	file.close()
	global.pScore      = 0
	global.pColor      = 0
	global.pHealth     = 3
	global.enemyNumber = 1
	var dir = Directory.new()
	dir.remove("user://savegame.bin")

func _on_TextureButton_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
