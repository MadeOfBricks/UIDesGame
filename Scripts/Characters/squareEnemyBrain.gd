extends Node2D

onready var body = get_parent()
var walkSpeed = 200
var currentAction = ""
var walkVec = Vector2(1,0)
onready var lastPivot = body.get_pos()

#Signals for sprite
signal walk_left
signal walk_right
signal body_walk

#Set process
func _ready():
	set_process(true)
	pass

#Set currentAction and handle input for walking
#Use delta time
func _process(delta):
	currentAction = "walk"
	#print(lastPivot)
	if abs(body.get_pos().distance_to(lastPivot)) > 50:
		lastPivot = body.get_pos()
		walkVec = walkVec.rotated(deg2rad(90))
	
	var newPosVec = (walkVec.normalized() * walkSpeed * delta)
	emit_signal("body_walk",newPosVec)
	