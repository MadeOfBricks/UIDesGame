extends Control

onready var main = get_parent().get_parent()
onready var debug = main.get_node("DBText")

onready var initialDeclared = false

var initialTouch = Vector2(0,0)

var tapped=false

signal walk_input

func _ready():
	pass

func _draw():
	set_pos(Vector2(0,0))
	set_size(Vector2(OS.get_window_size().x/2,OS.get_window_size().y))
	var r = Rect2( Vector2(), get_size() )
	if (tapped):
	    draw_rect(r, Color(1,0,0) )
	else:
	    draw_rect(r, Color(0,0,1) )



func _on_Left_input_event( ev ):
	if ev.type == InputEvent.MOUSE_BUTTON:
		initialTouch = ev.pos
	elif (ev.type==InputEvent.MOUSE_MOTION):
		#debug._set_text(String(ev.pos))
		var vec = ev.pos - initialTouch
		emit_signal("walk_input",vec)
