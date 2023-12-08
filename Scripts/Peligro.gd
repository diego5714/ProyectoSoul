extends AudioStreamPlayer

@onready var peligro = $"."



func _on_finished():
	peligro.play()
