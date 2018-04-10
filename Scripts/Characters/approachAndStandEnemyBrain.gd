extends Node2D

onready var body = get_parent()
onready var main = body.get_parent()
var walkSpeed = 200
var turnSpeed = 2
var currentAction = ""
var walkVec = Vector2(1,0)

onready var lastPivot = body.get_pos()
onready var target


onready var printStrings = []


#Signals for sprite
signal body_walk

#Set process
func _ready():
	set_process(true)
	pass

#Set currentAction and handle input for walking
#Use delta time
func _process(delta):
	currentAction = "stand"
	#print("we here?")
	if main.has_node("PlayerBody"):
		target = main.get_node("PlayerBody")
		if abs(body.get_pos().distance_to(target.get_pos())) > 300:
			currentAction = "walk"
	
	if currentAction == "walk":
		var dirVec = target.get_pos() - body.get_pos()
		walkVec = dirVec
		
		var newPosVec = (walkVec.normalized() * walkSpeed/2 * delta)
		if(body.is_colliding()):
			var n = body.get_collision_normal()
			newPosVec = n.slide(newPosVec)
			walkVec = n.slide(walkVec)
		emit_signal("body_walk",newPosVec)
