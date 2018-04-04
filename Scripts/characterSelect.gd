extends Node2D
var spawn_items = [
    preload("res://Sprites/Reapy_0.png"),
    preload("res://Sprites/ReapyR_0.png"),
    preload("res://Sprites/ReapyG_0.png"),
    preload("res://Sprites/ReapyB_0.png")
]
var data = {
    player_level = 0,
    player_type = 0
}

var count = 0
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_ButtonRight_released():
	count = count + 1
	if (count == 4):
		count = 0
	get_node("Character").texture = spawn_items[count]
	print(count)


func _on_ButtonLeft_released():
	count = count - 1
	if (count == -1):
		count = 3
	get_node("Character").texture = spawn_items[count]
	print(count)


func _on_ButtonStart_released():
	var file = File.new()
	data.player_type = count
	file.open("res://Packed/saveFile.txt", File.WRITE) 
	file.store_line(data.to_json())
	file.close()
	get_tree().change_scene("res://Scenes/mainGame.tscn")


func _on_Button_released():
	get_tree().change_scene("res://Scenes/titleScreen.tscn")
