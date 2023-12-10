extends MarginContainer

@onready var start := %Start
@onready var settings := %Settings
@onready var credits := %Credits
@onready var exit := %Exit
@onready var transitioner = $transiciones/Transitioner

var Click_Animation: bool = false

func _ready() -> void:
	if not Variables.gamestarted:
		transitioner.fadein()
		Variables.gamestarted = true
	else:
		transitioner.hide()
	
	start.set_deferred("disabled", false)
	settings.set_deferred("disabled", false)
	credits.set_deferred("disabled", false)
	exit.set_deferred("disabled", false)
	
	start.pressed.connect(_on_start_pressed)
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	%Start_Animations.play("RESET")
	%Settings_Animations.play("RESET")
	%Credits_Animations.play("RESET")
	%Exit_Animations.play("RESET")

func _on_start_pressed():
	start.set_deferred("disabled", true)
	
	%ClickSound.play()
	%Start_Animations.play("Pushed")
	Click_Animation = true
	await %Start_Animations.animation_finished
	get_tree().change_scene_to_file("res://Scenes/UI/Level_Selector.tscn")

func _on_settings_pressed():
	pass

func _on_credits_pressed():
	credits.set_deferred("disabled", true)
	
	%ClickSound.play()
	%Credits_Animations.play("Pushed")
	Click_Animation = true
	await %Credits_Animations.animation_finished
	
	get_tree().change_scene_to_file("res://Scenes/UI/Creditos.tscn")

func _on_exit_pressed():
	exit.set_deferred("disabled", true)
	
	%ClickSound.play()
	%Exit_Animations.play("Pushed")
	Click_Animation = true
	await %Exit_Animations.animation_finished
	
	get_tree().quit()

func _on_transitioner_fadein_finalizado():
	$transiciones.get_child(0).hide()

################################################################################

func _on_start_mouse_entered():
	if not Click_Animation:
		%Start_Animations.play("Hover") 

func _on_start_mouse_exited():
	if not Click_Animation:
		%Start_Animations.play("RESET")

################################################################################

func _on_settings_mouse_entered():
	if not Click_Animation:
		%Settings_Animations.play("Hover")

func _on_settings_mouse_exited():
	if not Click_Animation:
		%Settings_Animations.play("RESET")

################################################################################

func _on_credits_mouse_entered():
	if not Click_Animation:
		%Credits_Animations.play("Hover")

func _on_credits_mouse_exited():
	if not Click_Animation:
		%Credits_Animations.play("RESET")

################################################################################

func _on_exit_mouse_entered():
	if not Click_Animation:
		%Exit_Animations.play("Hover")

func _on_exit_mouse_exited():
	if not Click_Animation:
		%Exit_Animations.play("RESET")
