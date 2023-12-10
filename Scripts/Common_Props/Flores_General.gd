extends Area2D

@onready var sonido_flores = $Sonido_Flores

signal grown_now
var grown = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.get_name() == "Player" and grown == false:
		grown = true
		grown_now.emit()
		sonido_flores.play()
