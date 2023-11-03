
extends Node2D
var mostrar = false
var posicion = Vector2(-1984,416)

@onready var puente_llama: StaticBody2D = $Puente


func _process(_delta: float) -> void:
	if (mostrar == true):
		instanciar_puente()
		mostrar = false
	
func _on_button_button_pushed() -> void:
	mostrar = true
	
func instanciar_puente():
	if puente_llama != null:
		puente_llama.queue_free()
	var puente = load("res://Scenes/Puente_Llama.tscn").instantiate()
	self.add_child(puente)
	puente.global_position=posicion
	puente.scale= Vector2(2,2)
	
	


	
