extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(false)
	set_max_lines_visible(10)

func _process(delta):
	pass

func _add_line(string):
	set_text(get_text() + "\n" + string + "Lines:" + String(get_line_count() - 1))

func _set_text(string):
	set_text(string)