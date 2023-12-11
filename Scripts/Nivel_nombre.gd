extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var sprite_2d_2 = $Sprite2D2
@onready var sprite_2d_3 = $Sprite2D3
@onready var sprite_2d_4 = $Sprite2D4
@onready var sprite_2d_5 = $Sprite2D5


var tutorial = preload("res://Assets/Botones nivel 1 y 2/nv0.png")
var nivel1 = preload("res://Assets/Botones nivel 1 y 2/nv1.png")
var nivel2 = preload("res://Assets/Botones nivel 1 y 2/nv2.png")

func _ready():
	Variables.nivel_texto = self

func start():
	move(sprite_2d,0)
	move(sprite_2d_2,0.1)
	move(sprite_2d_3,0.2)
	move(sprite_2d_4,0.3)
	move(sprite_2d_5,0.4)

func move(sprite, delay):
	sprite.position.x = -255
	var tween = create_tween()
	tween.tween_property(sprite,"position:x",800,1.1).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).set_delay(delay)
	tween.tween_property(sprite,"position:x",1855,1.1).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)

func start_tutorial():
	new_texture(tutorial)
	start()
	
func start_nivel_1():
	new_texture(nivel1)
	start()

func start_nivel_2():
	new_texture(nivel2)
	start()

func new_texture(value):
	sprite_2d.texture = value
	sprite_2d_2.texture = value
	sprite_2d_3.texture = value
	sprite_2d_4.texture = value
	sprite_2d_5.texture = value
