extends Node2D

onready var global = get_tree().get_root().get_node("/root/global")

func _ready():
	var x = 0
	var y = 0
	global.enemyNumber += 1
	while x < OS.get_window_size().x:
		while y < OS.get_window_size().y:
			print(x + ", ", y)
			y += 32
		x += 32
	
