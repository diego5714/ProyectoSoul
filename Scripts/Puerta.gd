extends Node2D

var llave = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		if llave == true:
			Debug.dprint("Puerta abierta")
			queue_free()
		
func _on_llave_puerta_llave() -> void:
	llave = true
