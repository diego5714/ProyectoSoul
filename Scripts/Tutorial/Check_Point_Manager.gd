extends Node2D

@onready var cp_1: Area2D = $CP_1
@onready var cp_2: Area2D = $CP_2

func _ready():
	cp_1.body_entered.connect(_cp_1_entered)
	cp_2.body_entered.connect(_cp_2_entered)

func _cp_1_entered(body):
	if body.get_name() == "Player":
		body.set_current_cp(cp_1.get_node("Marker2D").get_global_position())
		cp_1.queue_free()

func _cp_2_entered(body):
	if body.get_name() == "Player":
		body.set_current_cp(cp_2.get_node("Marker2D").get_global_position())
		Debug.dprint(cp_2.get_node("Marker2D").get_global_position())
		cp_2.queue_free()
