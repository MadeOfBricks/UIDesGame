extends Node

onready var main = get_parent()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_Continue_released():
	queue_free()
	get_tree().set_pause(false)


func _on_Quit_released():
	queue_free()
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
	get_tree().set_pause(false)
