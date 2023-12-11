extends Node2D

@onready var transitioner = $transiciones/Transitioner

func _ready():
	transitioner.fadein()
	if Variables.nivel_texto:
		Variables.nivel_texto.start_nivel_1()

func _on_transitioner_fadein_finalizado():
	$transiciones.get_child(0).hide()
