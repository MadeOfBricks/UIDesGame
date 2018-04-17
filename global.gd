extends Node

onready var enemyNumber = 1
var current_scene = null

func _ready():
	print("I'm here?")
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )