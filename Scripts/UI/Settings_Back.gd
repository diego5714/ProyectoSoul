extends Button

@onready var back_animations = %Back_Animations

var Click_Animation: bool = false

func _ready():
	set_deferred("disabled", false)
	pressed.connect(_on_back_pressed)
	mouse_entered.connect(_on_back_mouse_entered)
	mouse_exited.connect(_on_back_mouse_exited)
	%Back_Animations.play("RESET")

func _on_back_pressed():
	set_deferred("disabled", true)
	
	%Click_Sound.play()
	%Back_Animations.play("Pushed")
	Click_Animation = true
	await %Back_Animations.animation_finished
	
	var Menu := preload("res://Scenes/UI/Main_Menu.tscn")
	get_tree().change_scene_to_packed(Menu)

func _on_back_mouse_entered():
	if not Click_Animation:
		%Back_Animations.play("Hover")

func _on_back_mouse_exited():
	if not Click_Animation:
		%Back_Animations.play("RESET")
