extends HSlider

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("value_changed",self,"_on_value_changed")
	
func _on_value_changed(val):
	print("Slider: " + String(get_value()))
	global.masterVolume = val/100
