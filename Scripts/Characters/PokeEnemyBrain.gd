extends Node2D

onready var body = get_parent()
onready var main = body.get_parent()
onready var timer = get_node("Timer")
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
	timer.connect("timeout",self,"_on_timeout")
	set_process(true)
	pass

#Set currentAction and handle input for walking
#Use delta time
func _process(delta):
	currentAction = "stand"
	if main.has_node("PlayerBody"):
		target = main.get_node("PlayerBody")
		if abs(body.get_pos().distance_to(target.get_pos())) > 50:
			currentAction = "walk"
	
	if currentAction == "walk":
		var dirVec = target.get_pos() - body.get_pos()
		
		
		walkVec = dirVec
		
		#var thisWalkVec = walkVec.rotated(ang)
		var newPosVec = (walkVec.normalized() * walkSpeed/2 * delta)
		if(body.is_colliding()):
			var n = body.get_collision_normal()
			newPosVec = n.slide(newPosVec)
			walkVec = n.slide(walkVec)
		
		emit_signal("body_walk",newPosVec)

func _on_timeout():
	for strings in printStrings:
		print(strings)
	printStrings.clear()