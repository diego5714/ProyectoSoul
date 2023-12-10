extends Area2D

@onready var sonido_flores = $Sonido_Flor
@onready var flores_variante = $"."

signal grown_now
var grown = false
var crecer = false
func _ready():
	body_entered.connect(_on_body_entered)
func permitir_crecer():
	crecer = true
	
func _on_body_entered(body):
	if body.get_name() == "Player" and grown == false and crecer == true:
		grown = true
		grown_now.emit()
		sonido_flores.play()

