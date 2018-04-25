extends Node2D
var gameState = true

onready var global = get_tree().get_root().get_node("/root/global")

onready var player = get_node("PlayerBody")
onready var dBText = get_node("DBText")

onready var playerSprites = preload("res://Packed/PlayerSprites/Player_Sprite_Bk.tscn")

func _ready():
	get_node("Label").hide()
	var item = preload("res://Scenes/trainingScreen.tscn").instance()
	add_child(item)
	
	get_node("PlayerBody/Sprite").queue_free()
	var spriteNode = playerSprites.instance()
	player.add_child(spriteNode)
	player.get_node("Brain").mySprite = spriteNode


func _on_back_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
