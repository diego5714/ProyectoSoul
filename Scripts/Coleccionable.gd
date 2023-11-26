extends Node2D
@onready var animation_player: AnimationPlayer = $Textura/AnimationPlayer
@onready var Area = $Area2D
@onready var colleccionable_sound = $SFX/Colleccionable_Sound
@onready var area_2d = $Area2D

func _ready() -> void:
	animation_player.play("animacion")
	Area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.get_name() == 'Player':
		Variables.Coleccionables += 1
		colleccionable_sound.play()
		Area.body_entered.disconnect(_on_body_entered)
		visible = false
		await colleccionable_sound.finished
		queue_free()
