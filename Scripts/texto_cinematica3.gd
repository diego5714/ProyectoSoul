extends Control

@onready var label = $MarginContainer/PanelContainer/VSplitContainer/MarginContainer2/VBoxContainer/MarginContainer/Label
@onready var transitioner = $transiciones/Transitioner
@export var Nivel_1: PackedScene = preload("res://Scenes/Level_Scenes/Nivel_1.tscn")

var text = 'Two halves of the same soul, which were now destined to feel incomplete...

Or so they thought for a long time....'
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
		
		Variables.NivelCargado = Nivel_1
		Variables.Textos_Visibles = false
		Variables.MaxDepth = 1600
		var Main := preload("res://Scenes/UI/Split_Camera.tscn")
		get_tree().change_scene_to_packed(Main)
		
	if Input.is_action_just_pressed("Pause"):
		transitioner.fadeout()
		await transitioner.fadeout_finalizado
		
		Variables.NivelCargado = Nivel_1
		Variables.Textos_Visibles = false
		Variables.MaxDepth = 1600
		var Main := preload("res://Scenes/UI/Split_Camera.tscn")
		get_tree().change_scene_to_packed(Main)

func _on_transitioner_fadein_finalizado():
	pass

func _on_transitioner_fadeout_finalizado():
	pass
