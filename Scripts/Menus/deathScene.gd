extends Node2D

onready var global = get_tree().get_root().get_node("/root/global")

onready var playerSprites = [
	preload("res://Sprites/Reapy_0.png"),
	preload("res://Sprites/ReapyR_0.png"),
	preload("res://Sprites/ReapyG_0.png"),
	preload("res://Sprites/ReapyB_0.png")
]
onready var labels = [
    "VBoxContainer 2/Label 1",
    "VBoxContainer 2/Label 2",
    "VBoxContainer 2/Label 3",
    "VBoxContainer 2/Label 4",
    "VBoxContainer 2/Label 5",
    "VBoxContainer3/Label 1",
    "VBoxContainer3/Label 2",
    "VBoxContainer3/Label 3",
    "VBoxContainer3/Label 4",
    "VBoxContainer3/Label 5" 
]
onready var labels1 = [
    "VBoxContainer/Label1",
    "VBoxContainer/Label2",
    "VBoxContainer/Label3",
    "VBoxContainer/Label4",
    "VBoxContainer/Label5",
    "VBoxContainer1/Label1",
    "VBoxContainer1/Label2",
    "VBoxContainer1/Label3",
    "VBoxContainer1/Label4",
    "VBoxContainer1/Label5" 
]
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var coloor = -1

func _ready():
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
	
	var i = 0
	
	
	var dir = Directory.new()
	dir.remove("user://highScores.bin")
	
	i = 0
	var tmp = 0
	while i < 10:
		if global.pScore > global.scores[i]:
			if (coloor == -1):
				coloor = i
				get_node(labels[i]).set("custom_colors/font_color", Color(1,1,0,1))
				get_node(labels1[i]).set("custom_colors/font_color", Color(1,1,0,1))
			tmp = global.scores[i]
			global.scores[i] = global.pScore
			global.pScore = tmp
		i += 1
	var file
	file = File.new()
	file.open_encrypted_with_pass("user://highScores.bin", File.WRITE, OS.get_unique_ID())
	i = 0
	while (i < 10):
		file.store_16(global.scores[i])
		i += 1
	file.close()
	
	i = 0
	while i < 5:
		print ("Score2: %d" % global.scores[i])
		i += 1
	
	get_node("VBoxContainer 2/Label 1").set_text("%d pts" % global.scores[0])
	get_node("VBoxContainer 2/Label 2").set_text("%d pts" % global.scores[1])
	get_node("VBoxContainer 2/Label 3").set_text("%d pts" % global.scores[2])
	get_node("VBoxContainer 2/Label 4").set_text("%d pts" % global.scores[3])
	get_node("VBoxContainer 2/Label 5").set_text("%d pts" % global.scores[4])
	get_node("VBoxContainer3/Label 1").set_text("%d pts" % global.scores[5])
	get_node("VBoxContainer3/Label 2").set_text("%d pts" % global.scores[6])
	get_node("VBoxContainer3/Label 3").set_text("%d pts" % global.scores[7])
	get_node("VBoxContainer3/Label 4").set_text("%d pts" % global.scores[8])
	get_node("VBoxContainer3/Label 5").set_text("%d pts" % global.scores[9])
	
	
	global.pScore      = 0
	global.pColor      = 0
	global.pHealth     = 3
	global.firstLoad   = true
	global.enemyNumber = 1
	global.enemyAttackSpeed = 150
	global.enemyTurnSpeed = 2
	var dir = Directory.new()
	dir.remove("user://savegame.bin")

func _on_TextureButton_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
