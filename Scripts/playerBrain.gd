extends Node2D

onready var body = get_parent()
var walkSpeed = 200
var currentAction = ""

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
	_handle_input(delta)
	

func _handle_input(delta):
	#Walker
	var walkVec = Vector2(0,0)
	
	if Input.is_action_pressed("Up"):
		walkVec.y -= 5
		currentAction = "walk"
	if Input.is_action_pressed("Down"):
		walkVec.y += 5
		currentAction = "walk"
	if Input.is_action_pressed("Left"):
		walkVec.x -= 5
		currentAction = "walk"
	if Input.is_action_pressed("Right"):
		walkVec.x += 5
		currentAction = "walk"
	
	
	if currentAction =="walk":
		var newPosVec = (walkVec.normalized() * walkSpeed * delta)
		emit_signal("body_walk",newPosVec)
	
	