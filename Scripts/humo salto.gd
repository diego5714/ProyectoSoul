extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

func humo():
	sprite.show()
	animation_player.play("humo")
	await animation_player.animation_finished
	sprite.hide()
