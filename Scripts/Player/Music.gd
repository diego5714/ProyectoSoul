extends AudioStreamPlayer

func _ready():
	finished.connect(_on_music_finished)

func _on_music_finished():
	play()
