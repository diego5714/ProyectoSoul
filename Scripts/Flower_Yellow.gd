extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var flower_yellow = $"."


	


func _on_flowersss_grown_now():
	#animation_player.playback.travel("semilla")
	Debug.dprint("growing")
	animation_player.play("Growing")





func _on_area_flores_1a_crece():
	animation_player.play("Growing")
	


func _on_area_flores_1b_crece():
	animation_player.play("Growing")
	


func _on_area_flores_1b_2_crece():
	animation_player.play("Growing")
