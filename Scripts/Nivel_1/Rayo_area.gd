extends Area2D

@onready var timer = $Timer
@onready var sonido_rayos = $Sonido_Rayos

var player_inside: bool = false

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	timer.start()

func _on_timer_timeout():
	if player_inside:
		sonido_rayos.play()

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		player_inside = true

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		player_inside = false
