extends Node2D

onready var body = get_parent()
onready var main = body.get_parent()
onready var mySprite = body.get_node("Sprite")
onready var timer = get_node("Timer")
var walkSpeed = 200
var turnSpeed = 2
var spikeSpeed = 50
var followDist = 150
var lastFrame = 0
var currentAction = ""
var walkVec = Vector2(1,0)

onready var lastPivot = body.get_pos()
onready var target = null


onready var printStrings = []


#Signals for sprite
signal body_walk
signal body_attack

#Set process
func _ready():
	currentAction = "stand"
	timer.connect("timeout",self,"_on_timeout")
	set_process(true)
	pass

#Set currentAction and handle input for walking
#Use delta time
func _process(delta):
	if main.has_node("PlayerBody"):
			if target == null:
				target = main.get_node("PlayerBody")
	else:
		target = null
	
	if currentAction == "attackBegin" && target != null:
		if lastFrame != mySprite.get_frame() && mySprite.get_frame() == 2:
			var dirVec = target.get_pos() - body.get_pos()
			var spike = preload("res://Packed/Spike.tscn")
			var inst = spike.instance()
			inst.velocity = dirVec.normalized() * spikeSpeed * delta
			inst.set_pos(body.get_pos())
			main.add_child(inst)
	
	if target == null:
		currentAction == "stand"
	
	if mySprite.get_animation() != "attack" && currentAction == "attack":
		currentAction = "stand"
	
	#Walking
	if currentAction != "attack" && currentAction != "attackBegin" && currentAction != "attackCoolDown":
		if target != null:
			if abs(body.get_pos().distance_to(target.get_pos())) > followDist:
				currentAction = "walk"
			else:
				currentAction = "stand"
		else:
			currentAction = "stand"
	
	
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
	
	lastFrame = mySprite.get_frame()

func _on_timeout():
	currentAction = "attackBegin"
	print("poke")
	mySprite.set_animation("attack")