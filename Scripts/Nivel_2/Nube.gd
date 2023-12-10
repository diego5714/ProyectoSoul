extends Area2D

@onready var sprite_2d = $Sprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	sprite_2d.set_deferred('modulate', Color(1.0, 1.0, 1.0, 1.0))

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(sprite_2d, 'modulate', Color(1.0, 1.0, 1.0, 0.19), 1.0)

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(sprite_2d, 'modulate', Color(1.0, 1.0, 1.0, 1.0), 1.0)
