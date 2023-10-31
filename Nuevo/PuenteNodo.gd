extends Node2D
var mostrar = false
var posicion = Vector2(-1984,416)

func _process(_delta: float) -> void:
	if (mostrar == true):
		instanciar_puente()
		mostrar = false
	
func _on_button_button_pushed() -> void:
	mostrar = true
	
func instanciar_puente():
	var puente = load("res://Scenes/Puente_Madera.tscn").instantiate()
	self.add_child(puente)
	puente.global_position=posicion
	puente.scale= Vector2(2,2)
	
	
