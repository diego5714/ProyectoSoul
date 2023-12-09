extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var timer: Timer = $Timer

var player_inside: Node2D

func _ready():
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		player_inside = body
		Debug.dprint("DAMAGE")
		player_inside.damage(1)
		timer.start()

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		player_inside = null
		timer.stop()

func _on_timer_timeout():
	if player_inside:
		Debug.dprint("DAMAGE")
		player_inside.damage(1)
