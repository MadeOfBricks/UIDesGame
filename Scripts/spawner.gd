extends Node

onready var global = get_tree().get_root().get_node("/root/global")
onready var main = get_parent()

onready var enemies = [
	preload("res://Packed/PokeEnemy.tscn"),
	preload("res://Packed/RushEnemy.tscn")
]

func _ready():
	var enInt 
	for i in range(global.enemyNumber):
		enInt = randi()%2
		var en = enemies[enInt].instance()
		var randX = randi() % int(OS.get_window_size().x)
		var randY = randi() % int(OS.get_window_size().y)
		en.set_pos(Vector2(randX,randY))
		main.call_deferred("add_child",en)
		main.call_deferred("_add_enemy",en)
		print(en.get_name() + " placed")
	
