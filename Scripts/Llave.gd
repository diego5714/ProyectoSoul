extends Area2D

signal puerta_llave

func _ready():
	$Sprite_Animation.play("Shine")
	$Position_Animation.play("wobble")

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		emit_signal("puerta_llave")
		Variables.Llaves_Recogidas += 1
		Debug.dprint("Llave recogida")
		queue_free()
