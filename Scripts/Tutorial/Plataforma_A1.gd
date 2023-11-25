extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var plataforma: CharacterBody2D = $Plataforma
@onready var plataforma_2: CharacterBody2D = $Plataforma2

@onready var boton_1: Area2D = $"../Boton_1"

func no_collisions(estado: bool):
	plataforma.set_collision_layer_value(2, not estado)
	plataforma.set_collision_mask_value(1, not estado)
	
	plataforma_2.set_collision_layer_value(2, not estado)
	plataforma_2.set_collision_mask_value(1, not estado)

func _ready():
	boton_1.button_pushed.connect(_on_boton_entered)
	no_collisions(false)
	
func _on_boton_entered():
	no_collisions(true)
	animation_player.play("Bridge")
	await animation_player.animation_finished
	
	Debug.dprint("Termine")
	no_collisions(false)
	

