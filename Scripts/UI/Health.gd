extends HBoxContainer

@onready var corazon_1 = $Corazon1
@onready var corazon_2 = $Corazon2
@onready var corazon_3 = $Corazon3

var empty_hearth: Resource = preload("res://Resources/Empty_Heart.tres")
var full_hearth: Resource = preload("res://Resources/Full_Heart.tres")

func _ready():
	corazon_1.texture = full_hearth
	corazon_2.texture = full_hearth
	corazon_3.texture = full_hearth

func _process(_delta):
	if Variables.current_health == 3:
		corazon_1.texture = full_hearth
		corazon_2.texture = full_hearth
		corazon_3.texture = full_hearth
	
	if Variables.current_health == 2:
		corazon_1.texture = full_hearth
		corazon_2.texture = full_hearth
		corazon_3.texture = empty_hearth
	
	if Variables.current_health == 1:
		corazon_1.texture = full_hearth
		corazon_2.texture = empty_hearth
		corazon_3.texture = empty_hearth
	
	if Variables.current_health == 0:
		corazon_1.texture = empty_hearth
		corazon_2.texture = empty_hearth
		corazon_3.texture = empty_hearth
