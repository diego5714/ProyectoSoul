extends Control

@export var Tutorial: PackedScene
@export var Nivel1: PackedScene
@export var Nivel2: PackedScene
@export var Nivel3: PackedScene

@onready var Boton1 := %Boton_1
@onready var Boton2 := %Boton_2
@onready var Boton3 := %Boton_3
@onready var Boton4 := %Boton_4
@onready var Back := %Back
var Click_Animation: bool = false

func _ready():
	Boton1.pressed.connect(_on_boton_1_pressed)
	Boton1.mouse_entered.connect(_on_boton_1_mouse_entered)
	Boton1.mouse_exited.connect(_on_boton_1_mouse_exited)
	%Boton_1_Animations.play("RESET")
	
	Boton2.pressed.connect(_on_boton_2_pressed)
	Boton2.mouse_entered.connect(_on_boton_2_mouse_entered)
	Boton2.mouse_exited.connect(_on_boton_2_mouse_exited)
	%Boton_2_Animations.play("RESET")
	
	Boton3.pressed.connect(_on_boton_3_pressed)
	Boton3.mouse_entered.connect(_on_boton_3_mouse_entered)
	Boton3.mouse_exited.connect(_on_boton_3_mouse_exited)
	%Boton_3_Animations.play("RESET")
	
	Boton4.pressed.connect(_on_boton_4_pressed)
	Boton4.mouse_entered.connect(_on_boton_4_mouse_entered)
	Boton4.mouse_exited.connect(_on_boton_4_mouse_exited)
	%Boton_4_Animations.play("RESET")
	
	Back.pressed.connect(_on_back_pressed)
	Back.mouse_entered.connect(_on_back_mouse_entered)
	Back.mouse_exited.connect(_on_back_mouse_exited)
	%Back_Animations.play("RESET")

func _on_boton_1_pressed():
	%Click_Sound.play()
	%Boton_1_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_1_Animations.animation_finished
	
	Variables.NivelCargado = Tutorial
	Variables.MaxDepth = 925
	var Main := preload("res://Scenes/UI/Split_Camera.tscn")
	
	get_tree().change_scene_to_packed(Main)

func _on_boton_2_pressed():
	%Click_Sound.play()
	%Boton_2_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_2_Animations.animation_finished
	
	Variables.NivelCargado = Nivel1
	Variables.MaxDepth = 1150
	var Main := preload("res://Scenes/UI/Split_Camera.tscn")
	
	get_tree().change_scene_to_packed(Main)
	
func _on_boton_3_pressed():
	%Click_Sound.play()
	%Boton_3_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_3_Animations.animation_finished
	
	Variables.NivelCargado = Nivel2
	Variables.MaxDepth = 1450
	var Main := preload("res://Scenes/UI/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)
	
func _on_boton_4_pressed():
	%Click_Sound.play()
	%Boton_4_Animations.play("Pushed")
	Click_Animation = true
	await %Boton_4_Animations.animation_finished
	
	Variables.NivelCargado = Nivel3
	Variables.MaxDepth = 1200
	var Main := preload("res://Scenes/UI/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)
	
func _on_back_pressed():
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

func _on_boton_1_mouse_entered():
	if not Click_Animation:
		%Boton_1_Animations.play("Hover")

func _on_boton_1_mouse_exited():
	if not Click_Animation:
		%Boton_1_Animations.play("RESET")
		pass

################################################################################

func _on_boton_2_mouse_entered():
	if not Click_Animation:
		%Boton_2_Animations.play("Hover")

func _on_boton_2_mouse_exited():
	if not Click_Animation:
		%Boton_2_Animations.play("RESET")

################################################################################

func _on_boton_3_mouse_entered():
	if not Click_Animation:
		%Boton_3_Animations.play("Hover")

func _on_boton_3_mouse_exited():
	if not Click_Animation:
		%Boton_3_Animations.play("RESET")

################################################################################

func _on_boton_4_mouse_entered():
	if not Click_Animation:
		%Boton_4_Animations.play("Hover")

func _on_boton_4_mouse_exited():
	if not Click_Animation:
		%Boton_4_Animations.play("RESET")
