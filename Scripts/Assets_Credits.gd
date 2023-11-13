extends Control

@onready var Back := $MarginContainer/PanelContainer/MarginContainer/Back
var Click_Animation: bool = false

func _ready():
	Back.pressed.connect(_on_back_pressed)
	Back.mouse_entered.connect(_on_back_mouse_entered)
	Back.mouse_exited.connect(_on_back_mouse_exited)
	%Back_Animations.play("RESET")

func _on_back_pressed():
	%Click_Sound.play()
	%Back_Animations.play("Pushed")
	Click_Animation = true
	await %Back_Animations.animation_finished
	
	get_tree().change_scene_to_file("res://Scenes/UI/Creditos.tscn")

func _on_back_mouse_entered():
	if not Click_Animation:
		%Back_Animations.play("Hover")

func _on_back_mouse_exited():
	if not Click_Animation:
		%Back_Animations.play("RESET")
