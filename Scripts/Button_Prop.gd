extends Area2D

signal button_pushed
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D

@export var persistente: bool = true


func _ready():
	set_deferred("monitoring", true)
	collision_shape_2d.set_deferred("disabled", false)
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	collision_shape_2d.set_deferred("disabled", true)
	
	if body.get_name() == "Player":
		emit_signal("button_pushed")
		Debug.dprint("Presionado")
		animation_player.play("Push")
