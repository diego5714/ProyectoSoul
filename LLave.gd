extends Area2D

signal puerta_llave

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		emit_signal("puerta_llave")
		print("llave cogida")
		queue_free()
	
