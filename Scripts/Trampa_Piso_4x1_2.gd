extends Area2D

var eliminar = false

func _process(_delta: float) -> void:
	if (eliminar == true):
		Eliminar_Trampa()
		eliminar = false
	
func Eliminar_Trampa():
	queue_free()

#Funcion conectada a Button4B
func _on_button_4b_button_pushed() -> void:
	if (eliminar == false):
		eliminar = true
	