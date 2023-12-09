extends Area2D
signal lightning


func _on_body_entered(body):
	if body.get_name() =="Player":
		emit_signal("lightning")
		
