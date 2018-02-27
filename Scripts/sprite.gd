extends Sprite

var main = get_parent()

func _ready():
	set_process(true)
	
	
func _process(delta):
	var randX = rand_range(0,1024)
	var randY = rand_range(0,600)
	set_pos(Vector2(randX,randY))
	
