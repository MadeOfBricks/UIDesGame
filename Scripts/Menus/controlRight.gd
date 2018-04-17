extends Control

onready var main = get_parent().get_parent()
onready var debug = main.get_node("DBText")

signal attack_input


func _ready():
	set_pos(Vector2(OS.get_window_size().x/2,50))
	#debug._set_text(String(get_pos()))

func _draw():
	set_size(Vector2(OS.get_window_size().x/2,OS.get_window_size().y))
	var r = Rect2( Vector2(), get_size())
	


func _on_Right_input_event( ev ):
	if ev.type == InputEvent.MOUSE_BUTTON:
		emit_signal("attack_input")
