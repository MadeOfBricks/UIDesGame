extends Node2D
var gameState = true

onready var global = get_tree().get_root().get_node("/root/global")

onready var player = get_node("PlayerBody")
onready var dBText = get_node("DBText")
onready var label = get_node("Label")

onready var playerSprites = [
	preload("res://Packed/PlayerSprites/Player_Sprite_Bk.tscn"),
	preload("res://Packed/PlayerSprites/Player_Sprite_Rd.tscn"),
	preload("res://Packed/PlayerSprites/Player_Sprite_Gn.tscn"),
	preload("res://Packed/PlayerSprites/Player_Sprite_Blu.tscn")
]
var score = 0

var HealthCo = [[1,0,0],[1,1,0],[0,1,0]]

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
	player.health = pData["pHealth"]
	var vec = Vector2((pData["pHealth"] * 50), 17)
	get_node("HealthBar").set_size(vec)
	get_node("HealthBar").set_frame_color(Color(HealthCo[player.health-1][0], HealthCo[player.health-1][1], HealthCo[player.health - 1][2]))
	get_node("Score").set_text("Score: %d" % score)
	get_node("PlayerBody/Sprite").queue_free()
	player.add_child(spriteNode)
	player.get_node("Brain").mySprite = spriteNode




func _process(delta):
	var xOut = player.get_pos().x > OS.get_window_size().x || player.get_pos().x < 0
	var yOut = player.get_pos().y > OS.get_window_size().y || player.get_pos().y < 0
	if xOut || yOut:
		var file = File.new()
		file.open("res://Packed/saveFile.sav", File.READ)
		var text = file.get_as_text()
		pData.parse_json(text)
		file.close()
	
		var dir = Directory.new()
		dir.remove("res://Packed/saveFile.sav")
		pData["pScore"] = score
		pData["pHealth"] = player.health
	
		var file = File.new()
		file.open("res://Packed/saveFile.sav", File.WRITE) 
		file.store_line(pData.to_json())
		file.close()
		get_tree().reload_current_scene()


func _on_Pause_pressed():
	var item = preload("res://Packed/pauseMenu.tscn").instance()
	add_child(item)
	get_tree().set_pause(true)



func _remove_enemy(en):
	score += 10
	get_node("Score").set_text("Score: %d" % score)
	enemies.remove(enemies.find(en))
	if enemies.size() == 0:
		label.set_text("Move to next area")
		set_process(true)

func _add_enemy(en):
	enemies.append(en)
