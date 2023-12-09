extends Node2D

@onready var button = $"../Botones/Button"

func _ready():
	button.button_pressed.connect(_on_button_pressed)

func _on_button_pressed():
	queue_free()
