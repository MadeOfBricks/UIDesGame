extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_MenuButton_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")

func _on_Back_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")


func _on_clearData_released():
	var dir = Directory.new()
	dir.remove("res://Packed/saveFile.sav")
	
	add_color_override("font_color", Color(207,0,0))
	set("custom_colors/font_color", Color(207,0,0))
	
	get_node("../Notifications").set_text("**Your previous game data has been deleted**")


func _on_ResetSettings_released():
	get_node("../HSlider").set_value(50)
