extends Node2D

onready var body = get_parent()

onready var mySprite = body.get_node("Sprite")
onready var mySpriteFrames = mySprite.get_sprite_frames()
onready var mySpriteLastFrame = 0
onready var timeSinceLastFrame = 0

onready var lvTimer = get_parent().get_parent().get_node("Timer")

onready var attacks = [
	preload("res://Packed/Attacks/Cut1.tscn")
]

var currentAttacks = [
	
]

var attackReady = true;

var walkSpeed = 200
var currentAction = ""

#Signals for sprite
signal body_walk

#Set process
func _ready():
	currentAction = "stand"
	set_process(true)
	pass

#Set currentAction and handle input for walking
#Use delta time
func _process(delta):
	if lvTimer.count <= -1:
		_handle_input(delta)
	

func _handle_input(delta):
	timeSinceLastFrame += delta
	#Attack Start
	if Input.is_action_pressed("MeleeAttack") && attackReady && currentAction != "meleeAttack":
		attackReady = false
		
		currentAction = "meleeAttack"
		
	
		mySprite.set_animation("Cut1")
		mySprite.set_frame(0)
	#Attack Running
	else:
		if mySprite.get_animation() == "Cut1":
			if mySprite.get_frame() != mySpriteLastFrame:
				timeSinceLastFrame = 0
			if mySprite.get_frame() == 1 && mySpriteLastFrame ==0:
				var cut = attacks[0].instance()
				var scale = mySprite.get_scale()
				cut.set_pos(Vector2(scale.x * 20,5))
				cut.scale(scale)
				cut.get_node("Sprite").play()
				get_parent().add_child(cut) 
			currentAction = "meleeAttack"
			mySpriteLastFrame = mySprite.get_frame();
		else:
			currentAction = "stand"
		if !Input.is_action_pressed("MeleeAttack"):
			attackReady = true;

	
	
	var walkVec = Vector2(0,0)
	
	if currentAction != "meleeAttack":
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
		
		if(body.is_colliding()):
			var n = body.get_collision_normal()
			newPosVec = n.slide(newPosVec)
			walkVec = n.slide(walkVec)
		
		emit_signal("body_walk",newPosVec)
	

