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

var HealthCo = [[1,0,0],[1,1,0],[0,1,0]]

var pData = {}

onready var enemies = get_tree().get_nodes_in_group("enemies")

func _ready():
	if global.firstLoad:
		print("We did first load")
		var file = File.new()
		file.open_encrypted_with_pass("user://savegame.bin", File.READ, OS.get_unique_ID())
		var text = file.get_as_text()
		pData.parse_json(text)
		file.close()
		global.enemyNumber = pData["eNum"]
		global.pScore = pData["pScore"]
		global.pHealth = pData["pHealth"]
		global.pColor = pData["pColor"]
		global.firstLoad = false
	var spriteNode = playerSprites[global.pColor].instance()
	var vec = Vector2((global.pHealth * 50), 17)
	get_node("HealthBar").set_size(vec)
	get_node("HealthBar").set_frame_color(Color(HealthCo[global.pHealth - 1][0], HealthCo[global.pHealth - 1][1], HealthCo[global.pHealth - 1][2]))
	get_node("Score").set_text("Score: %d" % global.pScore)
	get_node("PlayerBody/Sprite").queue_free()
	player.add_child(spriteNode)
	player.get_node("Brain").mySprite = spriteNode




func _process(delta):
	var ref = weakref(player)
	if ref.get_ref():
		var xOut = player.get_pos().x > OS.get_window_size().x || player.get_pos().x < 0
		var yOut = player.get_pos().y > OS.get_window_size().y || player.get_pos().y < 0
		if xOut || yOut:
			get_tree().reload_current_scene()


func _on_Pause_pressed():
	var item = preload("res://Packed/pauseMenu.tscn").instance()
	add_child(item)
	get_tree().set_pause(true)



func _remove_enemy(en):
	global.pScore += 10
	get_node("Score").set_text("Score: %d" % global.pScore)
	enemies.remove(enemies.find(en))
	if enemies.size() == 0:
		global.enemyNumber += 1
		label.set_text("Move to next area")
		set_process(true)

func _add_enemy(en):
	enemies.append(en)
