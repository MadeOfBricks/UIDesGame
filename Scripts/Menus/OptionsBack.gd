extends VBoxContainer

onready var hSlider = get_parent().get_node("HSlider")

func _ready():
	hSlider.set_value(global.masterVolume * 100)


func _on_MenuButton_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")


func _on_Back_released():
	#hSlider.get_value()
	get_tree().change_scene("res://Scenes/titleScreen.tscn")


func _on_clearData_released():
	var dir = Directory.new()
	dir.remove("user://savegame.bin")
	dir.remove("user://highscores.bin")
	
	global.enemyNumber = 0
	global.pColor = 0
	global.pScore = 0
	global.pHealth = 3
	global.firstLoad = true
	
	add_color_override("font_color", Color(207,0,0))
	set("custom_colors/font_color", Color(207,0,0))
	
	get_node("../Notifications").set_text("**Your previous game data has been deleted**")



func _on_ResetSettings_released():
	get_node("../HSlider").set_value(50)

