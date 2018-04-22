extends Control

onready var main = get_parent().get_parent()
onready var debug = main.get_node("DBText")
onready var viewSize = main.get_viewport_rect()

var lastVec = Vector2(0,0)

var tapped=false

signal walk_input

func _ready():
	set_process_input(true)
	var X = viewSize.end.x
	var Y = viewSize.end.y
	set_size(X,Y)
	


func _input(ev):
	if ev.x < viewSize.end.x:
		if ev.type == InputEvent.SCREEN_DRAG:
			
			var vec = ev.relative_pos
			#debug._set_text(String(vec))
			#debug._set_text("Length: " + String(vec.length()))
			
			if abs(vec.length()) >= 3:
				lastVec = vec
			else:
				#debug._add_line("Last is: " + String(lastVec))
				vec = lastVec
			
			#debug._add_line("Signaling with " + String(vec))
			emit_signal("walk_input",vec)
		
		if ev.type == InputEvent.SCREEN_TOUCH:
			var vec = lastVec
			emit_signal("walk_input",vec)
			#debug._add_line("TOUCH")

