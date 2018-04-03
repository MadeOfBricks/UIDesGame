extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Play_pressed():
	print("Play Button Pressed...")
	get_tree().change_scene("res://Scenes/mainGame.tscn")
	


func _on_Training_pressed():
	print("Training Button Pressed...")
	get_tree().change_scene("res://Scenes/trainingScreen.tscn")


func _on_Options_pressed():
	print("Options Button Pressed")
	get_tree().change_scene("res://Scenes/optionsScreen.tscn")
