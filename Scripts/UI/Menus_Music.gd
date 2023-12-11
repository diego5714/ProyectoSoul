extends AudioStreamPlayer

func _ready():
	play()

func _process(_delta):
	if not Variables.Current_Level == -1:
		stop()
	else:
		if not playing:
			play()
