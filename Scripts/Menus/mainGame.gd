extends Node2D

onready var player = get_node("PlayerBody")

onready var enemies = [
	get_node("FollowerBody")
]

func _ready():
	print(get_child_count())
	set_process(true)

func _process(delta):
	pass
