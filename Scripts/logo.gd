extends Control

@onready var timer = $transiciones/Timer
@onready var transitioner = $transiciones/Transitioner
var contador = 0

func _ready():
	transitioner.fadein()
	timer.start(2)

func _on_timer_timeout():
	if contador < 1:
		transitioner.fadeout()
		contador += 1

func _on_transitioner_fadeout_finalizado():
	get_tree().change_scene_to_file("res://Scenes/UI/Main_Menu.tscn")
