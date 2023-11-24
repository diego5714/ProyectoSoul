extends Node2D

@onready var animation_player = $AnimationPlayer

@onready var boton_1 = $"../Boton_1"

func _ready():
	boton_1.button_pushed.connect(_on_boton_entered)
	
func _on_boton_entered():
	animation_player.play("Bridge")
