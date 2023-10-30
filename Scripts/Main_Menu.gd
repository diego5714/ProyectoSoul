extends MarginContainer

@onready var start := %Start
@onready var settings := %Settings
@onready var credits := %Credits
@onready var exit := %Exit

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	credits.pressed.connect(_on_credits_pressed)
	%Button_Animations.play("RESET")

func _on_start_pressed():
	%ClickSound.play()
	%Button_Animations.play("Start_Pressed")
	await %Button_Animations.animation_finished
	
	get_tree().change_scene_to_file("res://Scenes/Level_Selector.tscn")

func _on_exit_pressed():
	$SFX/ClickSound.play()
	await $SFX/ClickSound.finished
	get_tree().quit()

func _on_credits_pressed():
	$SFX/ClickSound.play()
	await $SFX/ClickSound.finished
	get_tree().change_scene_to_file("res://Scenes/Creditos.tscn")
