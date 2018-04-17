extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Continue_released():
	queue_free()


func _on_Quit_released():
	queue_free()
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
