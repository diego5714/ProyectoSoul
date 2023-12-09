extends Area2D

@onready var peligro = $Peligro

func _on_body_entered(body):
	if body.get_name() == "Player":
		Debug.dprint("Warning ahora no permitida")
		peligro.play()

func _on_body_exited(_body):
	peligro.stop()


func _on_button_2b_button_pushed():
	queue_free()


func _on_button_3a_button_pushed():
	queue_free()