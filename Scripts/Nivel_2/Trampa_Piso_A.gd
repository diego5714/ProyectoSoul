extends Area2D

@onready var timer: Timer = $Timer
@onready var button_a = $"../../Botones/Button_A"


var player_inside: Node2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	timer.timeout.connect(_on_timer_timeout)
	button_a.button_pressed.connect(_on_button_pressed)

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		player_inside = body
		player_inside.damage(3)
		timer.start()

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		player_inside = null
		timer.stop()

func _on_timer_timeout():
	if player_inside:
		player_inside.damage(3)

func _on_button_pressed():
	queue_free()
