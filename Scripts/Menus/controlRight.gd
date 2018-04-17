extends Control

var tapped=false

func _draw():
	set_pos(Vector2(OS.get_window_size().x/2,0))
	
	set_size(Vector2(OS.get_window_size().x/2,OS.get_window_size().y))
	var r = Rect2( Vector2(), get_size())
	if (tapped):
	    draw_rect(r, Color(1,0,0) )
	else:
	    draw_rect(r, Color(0,0,1) )

func _input_event(ev):
	
	if (ev.type==InputEvent.SCREEN_TOUCH and ev.pressed):
	    tapped=true
	    update()