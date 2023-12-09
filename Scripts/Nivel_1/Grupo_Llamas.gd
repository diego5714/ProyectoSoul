extends Node2D

@onready var area_2d = $Area2D
@onready var sonido_fuego = $Sonido_Fuego

var player_inside: bool = false

func _ready():
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	sonido_fuego.finished.connect(_on_sound_finished)

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		sonido_fuego.play()
		player_inside = true

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		sonido_fuego.stop()
		player_inside = false

func _on_sound_finished():
	if player_inside:
		sonido_fuego.play()
