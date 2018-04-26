extends Control

onready var main = get_parent().get_parent()
onready var debug = main.get_node("DBText")
onready var viewSize = main.get_viewport_rect()

signal attack_input


func _ready():
	set_process_input(true)
	set_process_input(true)
	var X = viewSize.end.x
	var Y = viewSize.end.y
	set_size(Vector2(X,Y))
	set_pos(Vector2(OS.get_window_size().x/2,50))

func _draw():
	set_size(Vector2(OS.get_window_size().x/2,OS.get_window_size().y))
	var r = Rect2( Vector2(), get_size())


func _input(ev):
	if ev.type == InputEvent.SCREEN_TOUCH:
		if ev.x > get_pos().x:
			emit_signal("attack_input")


func _on_Right_input_event( ev ):
	if ev.type == InputEvent.MOUSE_BUTTON:
		emit_signal("attack_input")
