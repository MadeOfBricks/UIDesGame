extends TileMap

onready var main = get_parent()
onready var debug = main.get_node("DBText")

func _ready():
	var maxX = 0
	var maxY = 0
	debug.set_text(String(OS.get_screen_size()))
	for i in range(OS.get_screen_size().x/32 + 10):
		for j in range(OS.get_screen_size().y/32 + 10):
			set_cell(i,j,rand_range(0,12),rand_range(0,1),rand_range(0,1),rand_range(0,1))
			
	
