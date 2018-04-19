extends Area2D


func _ready(vec):
	set_layer_mask(16)
	set_collision_mask(1)
	set_pos(vec)
	connect("body_enter", self, "_on_body_enter")
	pass


func _on_body_enter(other):
	#main._remove_health_item(self)
	queue_free()