extends MarginContainer

@onready var start := %Start
@onready var settings := %Settings
@onready var credits := %Credits
@onready var exit := %Exit

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	credits.pressed.connect(_on_credits_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/creditos.tscn")
