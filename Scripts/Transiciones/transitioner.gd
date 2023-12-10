extends Control

class_name Transitioner

@onready var rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal fadeout_finalizado
signal fadein_finalizado

func fadeout():
	rect.show()
	animation_player.play("fade_out")
	await animation_player.animation_finished
	rect.hide()

func fadein():
	rect.show()
	animation_player.play("fade_in")
	await animation_player.animation_finished
	rect.hide()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		emit_signal("fadeout_finalizado")
	if anim_name == "fade_in":
		emit_signal("fadein_finalizado")
