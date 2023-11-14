extends Area2D

signal damage

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		emit_signal("damage")
		Debug.dprint("lost")
		print("lost")
	
