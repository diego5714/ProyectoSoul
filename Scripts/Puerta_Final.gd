extends Node2D

var llave: bool = false
var angulo: float = 0.0
var direccion: int = 0

@onready var timer = $Timer
@onready var PosBanana1 = $PosBanana1
@onready var PosBanana2 = $PosBanana2
var MaxPlatano1: int = 0
var MaxPlatano2: int = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		if llave == true:
			Variables.Ganaste = true
			timer.start()

func _on_llave_final_puerta_llave():
	llave = true

func _on_timer_timeout():
	var Platano = preload("res://Scenes/Banana.tscn")
	
	direccion = randi_range(0,1)
	
	Platano = Platano.instantiate()
	
	if direccion == 0:
		angulo = randf_range(4.85, 5.7)
		Variables.Fuerza_Platano = Vector2.from_angle(angulo) * 1200
		PosBanana1.add_child(Platano, true)
	else:
		angulo = randf_range(3.6, 4.5)
		Variables.Fuerza_Platano = Vector2.from_angle(angulo) * 1200
		PosBanana2.add_child(Platano)
	
	

