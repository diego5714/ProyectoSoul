extends Area2D

var button_push = false

func _ready() -> void:
	var button = $"../Button" #Referencia al boton emisor 
	button.button_pushed.connect(_appear_ladder())



func _appear_ladder():
	button_push = true
	show()

