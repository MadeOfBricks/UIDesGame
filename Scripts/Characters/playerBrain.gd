extends Node2D

onready var body = get_parent()
onready var main = body.get_parent()
onready var debug = main.get_node("DBText")
onready var controller = main.get_node("MobileController")
onready var samplePlayer = main.get_node("SamplePlayer")

onready var mySprite = body.get_node("Sprite")
onready var mySpriteFrames = mySprite.get_sprite_frames()
onready var mySpriteLastFrame = 0
onready var timeSinceLastFrame = 0

onready var dashTar = null

onready var lvTimer = get_parent().get_parent().get_node("Timer")

onready var attacks = [
	preload("res://Packed/Attacks/Cut1.tscn")
]
var controllerAttack = false
var controllerWalk = false

var currentAttacks = [
	
]

var attackReady = true;

var walkVec = Vector2(0,0)
var walkSpeed = 200
var dashSpeed = 800
var dashRange = 100
var framesSpentDashing = 0
var currentAction = ""

#Signals for sprite
signal body_walk
signal body_dash

#Set process
func _ready():
	currentAction = "stand"
	controller.get_node("Left").connect("walk_input",self,"_on_walk_input")
	controller.get_node("Right").connect("attack_input",self,"_on_attack_input")
	set_process(true)
	pass

#Set currentAction and handle input for walking
#Use delta time
func _process(delta):
	_handle_input(delta)
	

func _handle_input(delta):
	timeSinceLastFrame += delta
	#Attack Start
	var actionFree = currentAction != "meleeAttack" && currentAction != "dashTowards"
	if ((Input.is_action_pressed("MeleeAttack") || controllerAttack) && attackReady && actionFree):
		attackReady = false
		
		if currentAction != "dashTowards":
			currentAction = "dashTowards"
			dashTar = null
			for en in main.enemies:
				if dashTar != null && en != null:
					var enDist = body.get_pos().distance_squared_to(en.get_pos())
					var tarDist = body.get_pos().distance_squared_to(dashTar.get_pos())
					if enDist < tarDist:
						dashTar = en
				elif en != null:
					#print(en.get_name())
					if body.get_pos().distance_to(en.get_pos()) < 200 :
						dashTar = en
			if dashTar == null:
				currentAction = "stand"
			else:
				samplePlayer.play_sound("DashIn")
	
	elif currentAction != "dashTowards" && currentAction != "meleeAttack" && currentAction != "meleeCoolDown":
		currentAction = "stand"
		framesSpentDashing = 0
	
	if currentAction == "dashTowards":
		if dashTar != null:
			var approachSide = sign(dashTar.get_pos().x - body.get_pos().x)
			
			var adjustX = dashTar.get_pos().x - approachSide * 60
			var adjustVec = Vector2(adjustX,dashTar.get_pos().y)
			var dirVec = adjustVec - body.get_pos()
			framesSpentDashing += 60 * delta
			dirVec = dirVec.normalized() * dashSpeed * delta
			emit_signal("body_dash",dirVec)
			if body.get_pos().distance_squared_to(adjustVec) < dashSpeed + 50:
				body.set_pos(adjustVec)
				currentAction = "meleeAttack"
				if mySprite.get_scale().x != approachSide:
					mySprite.scale(Vector2(-1,1))
				mySprite.set_animation("Cut1")
				mySprite.set_frame(0)
			if framesSpentDashing >= 30 :
				currentAction = "stand"
	#Attack Running
	elif currentAction == "meleeAttack":
			var cut = attacks[0].instance()
			var scale = mySprite.get_scale()
			cut.set_pos(Vector2(scale.x * 20,5))
			cut.scale(scale)
			cut.get_node("Sprite").play()
			get_parent().add_child(cut)
			samplePlayer.play_sound("Cut1")
			currentAction = "meleeCoolDown"
	elif currentAction == "meleeCoolDown":
		if mySprite.get_animation() =="stand":
			currentAction = "stand"
	elif currentAction == "stand":
		if !Input.is_action_pressed("MeleeAttack"):
			attackReady = true;

	controllerAttack = false
	
	
	
	if currentAction != "meleeAttack" && currentAction != "meleeCoolDown" && currentAction != "dashTowards":
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
		
		if controllerWalk:
			currentAction = "walk"
		
	controllerWalk = false
	
	
	if currentAction =="walk":
		var newPosVec = (walkVec.normalized() * walkSpeed * delta)
		
		if(body.is_colliding()):
			var n = body.get_collision_normal()
			newPosVec = n.slide(newPosVec)
			walkVec = n.slide(walkVec)
		
		emit_signal("body_walk",newPosVec)
	walkVec = Vector2(0,0)
	

func _on_walk_input(vec):
	controllerWalk = true
	walkVec = vec

func _on_attack_input():
	debug._set_text("Player received signal")
	controllerAttack = true