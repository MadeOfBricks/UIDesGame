extends Node

onready var enemyNumber = 1
onready var enemyAttackSpeed = 150
onready var enemyTurnSpeed = 2
onready var pColor = 0
onready var pScore = 0
onready var pHealth = 3
onready var firstLoad = true

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )