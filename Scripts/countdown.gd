extends SamplePlayer
onready var nCount = get_node("../Timer")

onready var playing =[]
onready var playingIndeces = []

func _ready():
	set_process(true)
	pass


func _process(delta):
	for sound in playingIndeces:
		if !is_voice_active(sound):
			var index = playingIndeces.find(sound)
			playingIndeces.remove(index)
			print("removing " + playing[index])
			playing.remove(index)
			
		

func play_sound(sound):
	print(sound + " started")
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