extends Control

@export var Nivel1: PackedScene
@export var Nivel2: PackedScene
@export var Nivel3: PackedScene
@export var Nivel4: PackedScene

@onready var Boton1 := %Boton1
@onready var Boton2 := %Boton2
@onready var Boton3 := %Boton3
@onready var Boton4 := %Boton4
@onready var MainMenu := %MainMenu

func _ready():
	Boton1.pressed.connect(_on_boton_1_pressed)
	Boton2.pressed.connect(_on_boton_2_pressed)
	Boton3.pressed.connect(_on_boton_3_pressed)
	Boton4.pressed.connect(_on_boton_4_pressed)
	MainMenu.pressed.connect(_on_main_menu_pressed)

func _on_boton_1_pressed():
	Variables.NivelCargado = Nivel1
	Variables.MaxDepth = 925
	var Main := preload("res://Scenes/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)

func _on_boton_2_pressed():
	Variables.NivelCargado = Nivel2
	Variables.MaxDepth = 1150
	var Main := preload("res://Scenes/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)
	
func _on_boton_3_pressed():
	Variables.NivelCargado = Nivel3
	Variables.MaxDepth = 1450
	var Main := preload("res://Scenes/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)
	
func _on_boton_4_pressed():
	Variables.NivelCargado = Nivel4
	Variables.MaxDepth = 1200
	var Main := preload("res://Scenes/Split_Camera.tscn")
	get_tree().change_scene_to_packed(Main)
	
func _on_main_menu_pressed():
	var Menu := preload("res://Scenes/Main_Menu.tscn")
	get_tree().change_scene_to_packed(Menu)
