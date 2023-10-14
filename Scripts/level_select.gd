extends Control

@export var Nivel1: PackedScene
@export var Nivel2: PackedScene
@export var Nivel3: PackedScene
@export var Nivel4: PackedScene

@export var Main: PackedScene

@onready var Boton1 := %Boton1
@onready var Boton2 := %Boton2
@onready var Boton3 := %Boton3
@onready var Boton4 := %Boton4

func _ready():
	Boton1.pressed.connect(_on_boton_1_pressed)
	Boton2.pressed.connect(_on_boton_2_pressed)

func _on_boton_1_pressed():
	get_tree().change_scene_to_packed(Main)
	pass


func _on_boton_2_pressed():
	get_tree().change_scene_to_packed(Main)
	pass
