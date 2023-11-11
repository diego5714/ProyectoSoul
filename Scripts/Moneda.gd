extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("giro")
	



func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "PlayerA" or body.get_name() == "PlayerB":
		
		Variables.Monedas +=1
		#Debug.dprint("moneda recogida" + str(Variables.Monedas))
		queue_free()
	
