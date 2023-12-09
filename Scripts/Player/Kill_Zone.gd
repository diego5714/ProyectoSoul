extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer


func _ready():
	collision_shape_2d.set_deferred("disabled", false)
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		collision_shape_2d.set_deferred("disabled", true)
		body.kill()
		timer.start()

func _on_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
