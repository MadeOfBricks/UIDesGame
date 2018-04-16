extends Node2D

onready var body = get_parent()
onready var main = body.get_parent()
onready var debug = main.get_node("DBText")

onready var mySprite = body.get_node("Sprite")
onready var mySpriteFrames = mySprite.get_sprite_frames()
onready var mySpriteLastFrame = 0
onready var timeSinceLastFrame = 0

onready var dashTar = null

onready var lvTimer = get_parent().get_parent().get_node("Timer")

onready var attacks = [
	preload("res://Packed/Attacks/Cut1.tscn")
]

var currentAttacks = [
	
]

var attackReady = true;

var walkSpeed = 200
var dashSpeed = 800
var dashRange = 100
var currentAction = ""

#Signals for sprite
signal body_walk
signal body_dash

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
	var actionFree = currentAction != "meleeAttack" && currentAction != "dashTowards"
	if Input.is_action_pressed("MeleeAttack") && attackReady && actionFree:
		debug._add_line("press detected")
		attackReady = false
		
		currentAction = "dashTowards"
		dashTar = null
		for en in main.enemies:
			if dashTar != null:
				var enDist = body.get_pos().distance_squared_to(en.get_pos())
				var tarDist = body.get_pos().distance_squared_to(dashTar.get_pos())
				if enDist < tarDist:
					dashTar = en
			elif body.get_pos().distance_to(en.get_pos()) < 200:
				dashTar = en
		if dashTar == null:
			currentAction = "stand"
		
	elif currentAction != "dashTowards" && currentAction != "meleeAttack" && currentAction != "meleeCoolDown":
		currentAction = "stand"
	
	if currentAction == "dashTowards":
		if mySprite.get_animation() != "DashIn":
			mySprite.set_animation("DashIn")
		if dashTar != null:
			var adjustX = dashTar.get_pos().x - mySprite.get_scale().x * 60
			var adjustVec = Vector2(adjustX,dashTar.get_pos().y)
			var dirVec = adjustVec - body.get_pos()
			dirVec = dirVec.normalized() * dashSpeed * delta
			emit_signal("body_dash",dirVec)
			if body.get_pos().distance_squared_to(adjustVec) < dashSpeed * delta * 1.2:
				body.set_pos(adjustVec)
				currentAction = "meleeAttack"
				mySprite.set_animation("Cut1")
				mySprite.set_frame(0)
	#Attack Running
	elif currentAction == "meleeAttack":
			var cut = attacks[0].instance()
			var scale = mySprite.get_scale()
			cut.set_pos(Vector2(scale.x * 20,5))
			cut.scale(scale)
			cut.get_node("Sprite").play()
			get_parent().add_child(cut)
			print("Attack instantiated")
			currentAction = "meleeCoolDown"
	elif currentAction == "meleeCoolDown":
		if mySprite.get_animation() =="stand":
			currentAction = "stand"
		#print(currentAction)
	elif currentAction == "stand":
		if !Input.is_action_pressed("MeleeAttack"):
			attackReady = true;

	
	
	var walkVec = Vector2(0,0)
	
	if currentAction != "meleeAttack" && currentAction != "meleeCoolDown":
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
	

