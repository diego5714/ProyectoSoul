extends Area2D

signal crece
var crecio = false



func _on_body_entered(body):
	if body.get_name() == "Player" and crecio == false:
		crecio = true
		emit_signal("crece")
