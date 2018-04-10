extends RigidBody2D
var _player = null
func _ready():
    _player = get_node("../Body")
    add_to_group("block")
    set_process(true)
func _process(delta):
	pass
func hit_by_player():
    set_process(false)