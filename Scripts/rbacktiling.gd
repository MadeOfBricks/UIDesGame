extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	for i in range(1024):
		for j in range(600):
			set_cell(i,j,rand_range(0,12),rand_range(0,1),rand_range(0,1),rand_range(0,1))
