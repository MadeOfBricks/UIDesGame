extends Node

onready var global = get_tree().get_root().get_node("/root/global")
onready var main = get_parent()

onready var enemies = [
	preload("res://Packed/PokeEnemy.tscn"),
	preload("res://Packed/RushEnemy.tscn")
]

onready var rock = preload("res://Packed/Wall.tscn")

func _ready():
	var enInt 
	if global.enemyNumber == 0:
		global.enemyNumber = 1
		
	for i in range(global.enemyNumber):
		enInt = randi()%2
		var en = enemies[enInt].instance()
		var screenSize = main.get_viewport_rect()
		var randX = randi() % int(screenSize.end.x - 80) + 40
		var randY = randi() % int(screenSize.end.y - 80) + 40
		en.set_pos(Vector2(randX,randY))		
		main.call_deferred("add_child",en)
		main.call_deferred("_add_enemy",en)
		en.call_deferred("_set_Attack_Speed",global.enemyAttackSpeed)
		en.call_deferred("_set_Turn_Speed",global.enemyTurnSpeed)
		
	var rockInt = randi() % 3 + 2
	for i in range(rockInt):
		var randX = randi() % int(OS.get_window_size().x)
		var randY = randi() % int(OS.get_window_size().y)
		var thisRock = rock.instance()
		thisRock.set_pos(Vector2(randX,randY))
		main.call_deferred("add_child",thisRock)
		
