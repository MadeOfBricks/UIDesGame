extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var count = 0;
func _ready():
	get_node("ColorFrame 3").hide()
	get_node("Label 3").hide()
	get_node("ColorFrame 4").hide()
	get_node("Label 4").hide()
	get_node("Label").hide()


func _on_MenuButton_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")


func _on_ColorFrame_5_input_event( ev ):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.is_pressed()):
			if (count == 0):
				get_node("ColorFrame 3").show()
				get_node("Label 3").show()
				get_node("ColorFrame 2").hide()
				get_node("Label 2").hide()
				count = 1
			elif (count == 1):
				get_node("ColorFrame 4").show()
				get_node("Label 4").show()
				get_node("Label").show()
				get_node("ColorFrame 3").hide()
				get_node("Label 3").hide()
				count += 1
			elif (count > 1):
				get_node("ColorFrame 4").hide()
				get_node("Label").hide()
				get_node("Label 4").hide()
				queue_free()