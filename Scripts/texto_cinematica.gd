extends Control

@onready var label = $MarginContainer/PanelContainer/VSplitContainer/MarginContainer2/VBoxContainer/MarginContainer/Label
@onready var transitioner = $transiciones/Transitioner

var text = 'In ancient times, a fierce battle between two deities shook the firmament'
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

func _on_transitioner_fadein_finalizado():
	pass

func _on_transitioner_fadeout_finalizado():
	pass
