extends AnimatedSprite

onready var body = get_parent()
onready var brain = body.get_node("Brain")
var timeElapsed = 0

func _ready():
	brain.connect("walk_left",self,"_on_walk_left")
	brain.connect("walk_right",self,"_on_walk_right")
	
	set_process(true)
	#brain.connect("walk",self,"_on_walk")

func _on_walk_left():
	if self.get_scale().x != -1:
		self.scale(Vector2(-1,1))

func _on_walk_right():
	if self.get_scale().x != 1:
		self.scale(Vector2(-1,1))

func _process(delta):
	timeElapsed = timeElapsed + delta
	
	if brain.currentAction == "walk":
		set_animation("walk")
	elif brain.currentAction == "stand":
		set_animation("stand")
	