extends Area2D

signal crece
signal aun_no
var crecio = false



func _on_body_entered(body):
	if body.get_name() == "Player" and crecio == false:
		crecio = true
		emit_signal("crece")
		emit_signal("aun_no")


func _on_area_flores_1a_2_aun_no():
	crecio = true


func _on_area_flores_1a_2_crece():
	crecio = false
