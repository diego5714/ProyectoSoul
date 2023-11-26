extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Area: Area2D = $Area2D
@onready var coin_sound = $SFX/Coin_Sound
@onready var collision_shape_2d = $Area2D/CollisionShape2D

func _ready() -> void:
	animation_player.play("giro")
	Area.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.get_name() == 'Player':
		Variables.Monedas +=1
		coin_sound.play()
		visible = false
		Area.body_entered.disconnect(_on_body_entered)
		await coin_sound.finished
		queue_free()
