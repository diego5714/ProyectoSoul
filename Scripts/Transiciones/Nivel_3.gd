extends Node2D

@onready var transitioner = $transiciones/Transitioner

func _ready():
	transitioner.fadein()

func _on_transitioner_fadein_finalizado():
	$transiciones.get_child(0).hide()
