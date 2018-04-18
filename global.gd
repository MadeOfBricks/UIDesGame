extends Node

onready var enemyNumber = 0
onready var pColor = 0
onready var pScore = 0
onready var pHealth = 3
onready var firstLoad = true

var current_scene = null

func _ready():
	print("I'm here?")
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )