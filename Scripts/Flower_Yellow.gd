extends Area2D
@onready var animation_player = $AnimationPlayer


	


func _on_flowersss_grown_now():
	
	Debug.dprint("growing")
	animation_player.play()
