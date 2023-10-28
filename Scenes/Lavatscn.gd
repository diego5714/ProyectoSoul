extends Area2D

signal damage

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		emit_signal("damage")
		Debug.dprint("lost")
		print("lost")


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		emit_signal("damage")
		Debug.dprint("lost")
		print("lost")
	
