extends AnimatedSprite

onready var body = get_parent()
onready var brain = body.get_node("Brain")
#onready var player = get_node("../Player")

var timeElapsed = 0

func _ready():
	brain.connect("body_walk",self,"_on_body_walk")
	brain.connect("body_dash",self,"_on_body_dash")

	connect("finished",self,"_on_anim_finished")
	set_process(true)

func _on_body_walk(vec):
	set_animation("walk")
	if vec.x < 0 && self.get_scale().x != -1:
		self.scale(Vector2(-1,1))
	elif vec.x > 0 && self.get_scale().x != 1:
		self.scale(Vector2(-1,1))

func _on_body_dash(vec):
	if get_animation() != "DashIn":
		set_animation("DashIn")
	
	if vec.x < 0 && self.get_scale().x != -1:
		self.scale(Vector2(-1,1))
	elif vec.x > 0 && self.get_scale().x != 1:
		self.scale(Vector2(-1,1))



func _process(delta):
	timeElapsed = timeElapsed + delta
	
	#if brain.currentAction == "walk":
	#	set_animation("walk")
	#if brain.currentAction == "stand":
		#set_animation("stand")

func _on_anim_finished():
	if get_animation() == "Cut1":
		set_animation("stand")
	if get_animation() == "walk":
		set_animation("stand")