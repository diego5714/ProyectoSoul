extends Control

class_name Transitioner

@onready var animation_tex: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal fadeout_finalizado

func fadeout():
	$AnimationPlayer.play("fade_out")

func fadein():
	$AnimationPlayer.play("fade_in")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		emit_signal("fadeout_finalizado")
