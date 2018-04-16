extends AnimatedSprite

onready var body = get_parent()
onready var brain = body.get_node("Brain")
#onready var player = get_node("../Player")

var timeElapsed = 0

func _ready():
	brain.connect("body_walk",self,"_on_body_walk")
	set_process(true)

func _on_body_walk(vec):
	set_animation("walk")
	if vec.x < 0 && self.get_scale().x != -1:
		self.scale(Vector2(-1,1))
	elif vec.x > 0 && self.get_scale().x != 1:
		self.scale(Vector2(-1,1))


func _process(delta):
	if brain.currentAction == "stand":
		set_animation("stand")