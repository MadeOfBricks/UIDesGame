extends SamplePlayer
onready var nCount = get_node("../Timer")
onready var global = get_tree().get_root().get_node("/root/global")

onready var playing =[]
onready var playingIndeces = []

func _ready():
	#print(global.masterVolume)
	set_default_volume(global.masterVolume)
	set_process(true)
	pass


func _process(delta):
	for sound in playingIndeces:
		if !is_voice_active(sound):
			var index = playingIndeces.find(sound)
			playingIndeces.remove(index)
			playing.remove(index)
			
		

func play_sound(sound):
	playingIndeces.append(play(sound))
	playing.append(sound)
	

func play_sound_once(sound):
	var looking = true
	while looking:
		if playing.has(sound):
			var index = playing.find(sound)
			playing.remove(index)
			stop(playingIndeces[index])
			playingIndeces.remove(index)
		else:
			looking = false
	play_sound(sound)