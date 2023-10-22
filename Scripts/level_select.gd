extends Control

@export var Nivel1: PackedScene
@export var Nivel2: PackedScene
@export var Nivel3: PackedScene
@export var Nivel4: PackedScene

@onready var Boton1 := %Boton1
@onready var Boton2 := %Boton2
@onready var Boton3 := %Boton3
@onready var Boton4 := %Boton4

func _ready():
	Boton1.pressed.connect(_on_boton_1_pressed)
	Boton2.pressed.connect(_on_boton_2_pressed)
	Boton4.pressed.connect(_on_boton_4_pressed)

func _on_boton_1_pressed():
	Variables.NivelCargado = Nivel1
	var Main = preload("res://Scenes/main.tscn")
	get_tree().change_scene_to_packed(Main)
	pass


func _on_boton_2_pressed():
	Variables.NivelCargado = Nivel2
	var Main = preload("res://Scenes/main.tscn")
	get_tree().change_scene_to_packed(Main)
	pass
	
func _on_boton_3_pressed():
	Variables.NivelCargado = Nivel3
	#var Main = preload("res://Scenes/main.tscn")
	#get_tree().change_scene_to_packed(Main)
	pass # Replace with function body.
	
func _on_boton_4_pressed():
	Variables.NivelCargado = Nivel4
	var Main = preload("res://Scenes/main.tscn")
	get_tree().change_scene_to_packed(Main)
