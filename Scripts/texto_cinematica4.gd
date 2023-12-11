extends Control

@onready var label = $MarginContainer/PanelContainer/VSplitContainer/MarginContainer2/VBoxContainer/MarginContainer/Label
@onready var transitioner = $transiciones/Transitioner

var text = 'The glowing moon illuminated the incredulous gaze of both creatures'
var t = Timer.new()
var vel_text = 0.035
var listo = false

func _ready():
	transitioner.fadein()
	_display_letter()

func _display_letter():
	for i in text:
		print(i)
		label.text += i
		await get_tree().create_timer(vel_text).timeout
	listo = true

func _process(delta):
	if Input.is_action_just_pressed("saltar"):
		vel_text = vel_text/10
	if Input.is_action_just_pressed("saltar") and listo == true:
		transitioner.fadeout()
		await transitioner.fadeout_finalizado
		get_tree().change_scene_to_file("res://Scenes/Cinemática final/2f.tscn")
	if Input.is_action_just_pressed("Pause"):
		transitioner.fadeout()
		await transitioner.fadeout_finalizado
		get_tree().change_scene_to_file("res://Scenes/UI/Main_Menu.tscn")

func _on_transitioner_fadein_finalizado():
	pass # Replace with function body.

func _on_transitioner_fadeout_finalizado():
	pass # Replace with function body.
