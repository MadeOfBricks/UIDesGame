extends Node

onready var enemyNumber = 1
onready var pColor = 0
onready var pScore = 0
onready var pHealth = 3
onready var firstLoad = true
onready var xpos = 750
onready var ypos = 350

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )