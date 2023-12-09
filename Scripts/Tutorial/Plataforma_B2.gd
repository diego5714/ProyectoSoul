extends Node2D

@onready var animation_player: AnimationPlayer = $Animation_Player_B2
@onready var plataforma: CharacterBody2D = $Plataforma
@onready var plataforma_2: CharacterBody2D = $Plataforma2
@onready var plataforma_3: CharacterBody2D = $Plataforma3
@onready var plataforma_4: CharacterBody2D = $Plataforma4
@onready var plataforma_5: CharacterBody2D = $Plataforma5
@onready var plataforma_6: CharacterBody2D = $Plataforma6

@onready var boton: Area2D = $"../Botones/Boton_Parkour_B"

func no_collisions(estado: bool):
	plataforma.set_collision_layer_value(2, not estado)
	plataforma.set_collision_mask_value(1, not estado)
	
	plataforma_2.set_collision_layer_value(2, not estado)
	plataforma_2.set_collision_mask_value(1, not estado)
	
	plataforma_3.set_collision_layer_value(2, not estado)
	plataforma_3.set_collision_mask_value(1, not estado)
	
	plataforma_4.set_collision_layer_value(2, not estado)
	plataforma_4.set_collision_mask_value(1, not estado)
	
	plataforma_5.set_collision_layer_value(2, not estado)
	plataforma_5.set_collision_mask_value(1, not estado)
	
	plataforma_6.set_collision_layer_value(2, not estado)
	plataforma_6.set_collision_mask_value(1, not estado)

func _ready():
	boton.button_pressed.connect(_on_boton_entered)
	no_collisions(false)
	
func _on_boton_entered():
	no_collisions(true)
	animation_player.play("Abrir_Camino_B")
	await animation_player.animation_finished
	
	no_collisions(false)
	

