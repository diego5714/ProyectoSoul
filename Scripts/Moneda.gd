extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Area: Area2D = $Area2D

func _ready() -> void:
	animation_player.play("giro")
	Area.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.get_name() == 'Player':
		Variables.Monedas +=1
		#Debug.dprint("moneda recogida" + str(Variables.Monedas))
		queue_free()
