extends Area2D

signal button_pushed
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		emit_signal("button_pushed")
		animation_player.play("Push")
		print("boton")
	
