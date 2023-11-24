extends Node2D

@onready var cp_1: Area2D = $CP_1

func _ready():
	cp_1.body_entered.connect(_cp_1_entered)


func _cp_1_entered(body):
	if body.get_name() == "Player":
		body.set_current_cp(cp_1.position)
