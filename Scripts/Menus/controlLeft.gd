extends Control

onready var debug = get_parent().get_node("DBText")

var tapped=false

signal walk_input
signal attack_input

func _draw():
	set_pos(0,0)
	set_size(Vector2(OS.get_window_size().x/2,OS.get_window_size().y))
	var r = Rect2( Vector2(), get_size() )
	if (tapped):
	    draw_rect(r, Color(1,0,0) )
	else:
	    draw_rect(r, Color(0,0,1) )

func _input_event(ev):
	
	if (ev.type==InputEvent.SCREEN_DRAG and ev.pressed):
	    emit_signal("walk_input",ev)
	    update()