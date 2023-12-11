extends Node2D

@export var llaves_necesarias: int = 1
var angulo: float = 0.0
var direccion: int = 0

@onready var timer = $Timer_Banana
@onready var PosBanana1 = $Pos_Banana_1
@onready var PosBanana2 = $Pos_Banana_2
var MaxPlatano1: int = 0
var MaxPlatano2: int = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		if not Variables.Current_Level == 2: #No es nivel 2
			if Variables.Llaves_Recogidas == llaves_necesarias:
				Variables.Ganaste = true
				timer.start()
		else: #Es nivel 2
			get_tree().change_scene_to_file("res://Scenes/Cinemática final/4f.tscn")
	

func _on_timer_timeout():
	var Platano = preload("res://Scenes/Props/Misc/Banana.tscn")
	
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
