extends MarginContainer

@onready var start = $PanelContainer/MarginContainer/VBoxContainer/Start
@onready var settings = $PanelContainer/MarginContainer/VBoxContainer/Settings
@onready var credits = $PanelContainer/MarginContainer/VBoxContainer/Credits
@onready var exit = $PanelContainer/MarginContainer/VBoxContainer/Exit



func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	
	
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
func _on_exit_pressed():
	get_tree().quit()
#func _on_credits_pressed():
	#get_tree().change_scene_to_file()
