extends Control

@onready var Back := $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Back
@onready var Assets := $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Assets
var Click_Animation: bool = false

func _ready():
	Back.pressed.connect(_on_back_pressed)
	Back.mouse_entered.connect(_on_back_mouse_entered)
	Back.mouse_exited.connect(_on_back_mouse_exited)
	
	Assets.pressed.connect(_on_assets_pressed)
	Assets.mouse_entered.connect(_on_assets_mouse_entered)
	Assets.mouse_exited.connect(_on_assets_mouse_exited)

################################################################################
	
func _on_back_pressed():
	%Click_Sound.play()
	%Back_Animations.play("Pushed")
	Click_Animation = true
	await %Back_Animations.animation_finished
	
	get_tree().change_scene_to_file("res://Scenes/UI/Main_Menu.tscn")
	
func _on_back_mouse_entered():
	if not Click_Animation:
		%Back_Animations.play("Hover")
	
func _on_back_mouse_exited():
	if not Click_Animation:
		%Back_Animations.play("RESET")
	
################################################################################

func _on_assets_pressed():
	%Click_Sound.play()
	%Assets_Animations.play("Pushed")
	Click_Animation = true
	await %Assets_Animations.animation_finished
	
	get_tree().change_scene_to_file("res://Scenes/UI/Assets_Credits.tscn")
	
func _on_assets_mouse_entered():
	if not Click_Animation:
		%Assets_Animations.play("Hover")

func _on_assets_mouse_exited():
	if not Click_Animation:
		%Assets_Animations.play("RESET")
