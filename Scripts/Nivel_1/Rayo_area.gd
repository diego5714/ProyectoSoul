extends Area2D

var player_inside: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		player_inside = true

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		player_inside = false
