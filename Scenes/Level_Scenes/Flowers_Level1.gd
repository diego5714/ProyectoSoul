extends Area2D
signal grown_now
var crecio = false


func _on_body_entered(body):
	Debug.dprint("FLowers")
	
	if body.get_name() == "Player" and crecio == false:
		crecio = true
		emit_signal("grown_now")
