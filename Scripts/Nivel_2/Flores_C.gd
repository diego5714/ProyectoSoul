extends Area2D

@onready var button_b = $"../../../Elementos/Botones/Button_B"
@onready var sonido_flores = $Sonido_Flores
var button_pressed: bool = false

signal grown_now
var grown = false

func _ready():
	body_entered.connect(_on_body_entered)
	button_b.button_pressed.connect(_on_button_pressed)

func _on_body_entered(body):
	if button_pressed:
		if body.get_name() == "Player" and grown == false:
			grown = true
			grown_now.emit()
			sonido_flores.play()

func _on_button_pressed():
	button_pressed = true
