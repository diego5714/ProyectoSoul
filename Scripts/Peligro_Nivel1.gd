extends Area2D

@onready var Peligro_sound = $AudioStreamPlayer



func _on_body_entered(body):
	if (body.get_name() == "Player"):
		Debug.dprint("Warning ahora no permitida")
		#Peligro_sound.play()
	
	
