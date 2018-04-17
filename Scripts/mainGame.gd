extends Node2D
var gameState = true
onready var player = get_node("PlayerBody")
onready var dBText = get_node("DBText")

onready var playerSprites = [
	preload("res://Packed/PlayerSprites/Player_Sprite_Bk.tscn"),
	preload("res://Packed/PlayerSprites/Player_Sprite_Rd.tscn"),
	preload("res://Packed/PlayerSprites/Player_Sprite_Gn.tscn"),
	preload("res://Packed/PlayerSprites/Player_Sprite_Blu.tscn")
]
var score = 0

var pData = {}


onready var enemies = get_tree().get_nodes_in_group("enemies")

func _ready():
	var file = File.new()
	file.open("res://Packed/saveFile.sav", File.READ)
	var text = file.get_as_text()
	pData.parse_json(text)
	file.close()
	var spriteNode = playerSprites[pData["pColor"]].instance()
	score = pData["pScore"]
	get_node("Score").set_text("Score: %d" % score)
	get_node("PlayerBody/Sprite").queue_free()
	player.add_child(spriteNode)
	player.get_node("Brain").mySprite = spriteNode




func _process(delta):
	pass


func _on_Pause_pressed():
	var item = preload("res://Packed/pauseMenu.tscn").instance()
	add_child(item)
	get_tree().set_pause(true)



func _remove_enemy(en):
	score += 10
	get_node("Score").set_text("Score: %d" % score)
	enemies.remove(enemies.find(en))

