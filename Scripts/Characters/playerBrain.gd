extends Node2D

onready var body = get_parent()
onready var mySprite = body.get_node("Sprite")
onready var lvTimer = get_parent().get_parent().get_node("Timer")

onready var attacks = [
	preload("res://Packed/Attacks/Cut1.tscn")
]
var attackReady = true;

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
	if lvTimer.count <= -1:
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
	
	if Input.is_action_pressed("MeleeAttack") && attackReady:
		attackReady = false
		var cut = attacks[0].instance()
		var scale = mySprite.get_scale()
		cut.set_pos(Vector2(scale.x * 20,5))
		cut.scale(scale)
		cut.get_node("Sprite").play()
		get_parent().add_child(cut) 
	elif !Input.is_action_pressed("MeleeAttack"):
		attackReady = true;
	
	if currentAction =="walk":
		var newPosVec = (walkVec.normalized() * walkSpeed * delta)
		
		if(body.is_colliding()):
			var n = body.get_collision_normal()
			newPosVec = n.slide(newPosVec)
			walkVec = n.slide(walkVec)
		
		emit_signal("body_walk",newPosVec)
	
	