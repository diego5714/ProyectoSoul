extends Node2D

@onready var animation_player: AnimationPlayer = $Animation_Player_A1
@onready var plataforma: CharacterBody2D = $Plataforma
@onready var plataforma_2: CharacterBody2D = $Plataforma2

@onready var boton: Area2D = $"../Botones/Boton_Puente"

func no_collisions(estado: bool):
	plataforma.set_collision_layer_value(2, not estado)
	plataforma.set_collision_mask_value(1, not estado)
	
	plataforma_2.set_collision_layer_value(2, not estado)
	plataforma_2.set_collision_mask_value(1, not estado)

func _ready():
	boton.button_pushed.connect(_on_boton_entered)
	no_collisions(false)
	
func _on_boton_entered():
	Debug.dprint("Boton Puente")
	no_collisions(true)
	animation_player.play("Puente")
	await animation_player.animation_finished
	
	no_collisions(false)
	

