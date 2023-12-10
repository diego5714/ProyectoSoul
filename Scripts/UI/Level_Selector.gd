extends Control

@export var Tutorial: PackedScene = preload("res://Scenes/Level_Scenes/Tutorial.tscn")
@export var Nivel_1: PackedScene = preload("res://Scenes/Level_Scenes/Nivel_1.tscn")
@export var Nivel_2: PackedScene = preload("res://Scenes/Level_Scenes/Nivel_2.tscn")
@onready var transitioner = $transiciones/Transitioner

@onready var Boton_Tutorial := %Boton_Tutorial
@onready var Boton_L1 := %Boton_L1
@onready var Boton_L2 := %Boton_L2
@onready var Back := %Back
var Click_Animation: bool = false

func _ready():
	Boton_Tutorial.set_deferred("disabled", false)
	Boton_Tutorial.pressed.connect(_on_boton_tutorial_pressed)
	Boton_Tutorial.mouse_entered.connect(_on_boton_tutorial_mouse_entered)
	Boton_Tutorial.mouse_exited.connect(_on_boton_tutorial_mouse_exited)
	%Boton_Tutorial_Animations.play("RESET")
	
	Boton_L1.set_deferred("disabled", false)
	Boton_L1.pressed.connect(_on_boton_L1_pressed)
	Boton_L1.mouse_entered.connect(_on_boton_L1_mouse_entered)
	Boton_L1.mouse_exited.connect(_on_boton_L1_mouse_exited)
	%Boton_L1_Animations.play("RESET")
	
	Boton_L2.set_deferred("disabled", false)
	Boton_L2.pressed.connect(_on_boton_L2_pressed)
	Boton_L2.mouse_entered.connect(_on_boton_L2_mouse_entered)
	Boton_L2.mouse_exited.connect(_on_boton_L2_mouse_exited)
	%Boton_L2_Animations.play("RESET")
	
	Back.set_deferred("disabled", false)
	Back.pressed.connect(_on_back_pressed)
	Back.mouse_entered.connect(_on_back_mouse_entered)
	Back.mouse_exited.connect(_on_back_mouse_exited)
	%Back_Animations.play("RESET")

func _on_boton_tutorial_pressed():
	Boton_Tutorial.set_deferred("disabled", true)
	
	%Click_Sound.play()
	%Boton_Tutorial_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_Tutorial_Animations.animation_finished
	transitioner.fadeout()
	await transitioner.fadeout_finalizado
	
	Variables.NivelCargado = Tutorial
	Variables.Textos_Visibles = true
	Variables.MaxDepth = 1000 #900 es el ideal
	var Main := preload("res://Scenes/UI/Split_Camera.tscn")
	
	get_tree().change_scene_to_packed(Main)

func _on_boton_L1_pressed():
	Boton_L1.set_deferred("disabled", true)
	
	%Click_Sound.play()
	%Boton_L1_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_L1_Animations.animation_finished
	transitioner.fadeout()
	await transitioner.fadeout_finalizado
	get_tree().change_scene_to_file("res://Scenes/Cinemática inicial/1.tscn")
	
func _on_boton_L2_pressed():
	Boton_L2.set_deferred("disabled", true)
	
	%Click_Sound.play()
	%Boton_L2_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_L2_Animations.animation_finished
	
	transitioner.fadeout()
	await transitioner.fadeout_finalizado
	
	Variables.NivelCargado = Nivel_2
	Variables.Textos_Visibles = false
	Variables.MaxDepth = 2000
	var Main := preload("res://Scenes/UI/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)
	
func _on_back_pressed():
	Back.set_deferred("disabled", true)
	
	%Click_Sound.play()
	%Back_Animations.play("Pushed")
	Click_Animation = true
	await %Back_Animations.animation_finished
	
	var Menu := preload("res://Scenes/UI/Main_Menu.tscn")
	get_tree().change_scene_to_packed(Menu)

################################################################################

func _on_back_mouse_entered():
	if not Click_Animation:
		%Back_Animations.play("Hover")

func _on_back_mouse_exited():
	if not Click_Animation:
		%Back_Animations.play("RESET")

################################################################################

func _on_boton_tutorial_mouse_entered():
	if not Click_Animation:
		%Boton_Tutorial_Animations.play("Hover")

func _on_boton_tutorial_mouse_exited():
	if not Click_Animation:
		%Boton_Tutorial_Animations.play("RESET")
		pass

################################################################################

func _on_boton_L1_mouse_entered():
	if not Click_Animation:
		%Boton_L1_Animations.play("Hover")

func _on_boton_L1_mouse_exited():
	if not Click_Animation:
		%Boton_L1_Animations.play("RESET")

################################################################################

func _on_boton_L2_mouse_entered():
	if not Click_Animation:
		%Boton_L2_Animations.play("Hover")

func _on_boton_L2_mouse_exited():
	if not Click_Animation:
		%Boton_L2_Animations.play("RESET")

################################################################################

func _on_transitioner_fadein_finalizado():
	pass # Replace with function body.

func _on_transitioner_fadeout_finalizado():
	pass # Replace with function body.
