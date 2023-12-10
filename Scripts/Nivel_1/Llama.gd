extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var fuego_sonido = $Fuego

var player_inside: Node2D = null

func _ready() -> void:
	animation_player.play("Idle")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	timer.timeout.connect(_on_timer_timeout)
	#fuego_sonido.play()

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		player_inside = body
		player_inside.damage(1)
		timer.start()

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		player_inside = null
		timer.stop()

func _on_timer_timeout():
	if player_inside:
		player_inside.damage(1)
