extends Node2D
var gameState = true
onready var player = get_node("PlayerBody")

onready var playerSprites = [
	preload("res://Packed/Player_Sprite_Bk.tscn"),
	preload("res://Packed/Player_Sprite_Rd.tscn"),
	preload("res://Packed/Player_Sprite_Gn.tscn"),
	preload("res://Packed/Player_Sprite_Blu.tscn")
]


func _ready():
	var file = File.new()
	file.open("res://Packed/saveFile.txt", File.READ)
	var colorNo = file.get_var()
	file.close()
	var spriteNode = playerSprites[colorNo].instance()
	get_node("PlayerBody/Sprite").queue_free()
	player.add_child(spriteNode)
	#set = get_node(colorPath)
	set_process(true)

func _process(delta):
	pass

func _on_Pause_released():
	var item = preload("res://Packed/pauseMenu.tscn").instance()
	get_parent().add_child(item)