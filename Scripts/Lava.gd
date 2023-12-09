extends Area2D

signal damage

@onready var timer = $Timer
@onready var tile_map = $TileMap

func _ready():
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		body.kill()
		emit_signal("damage")
	
func _on_timer_timeout():
	tile_map.scale.x *= -1
