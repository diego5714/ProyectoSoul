extends MarginContainer
@onready var labelMonedas = %Label_Monedas
@onready var labelLlaves = %Label_Numero
@onready var labelColeccionables = %Label_Colecccionables

func _process(_delta):
	labelMonedas.text = str(Variables.Monedas)
	labelLlaves.text = str(Variables.Llaves_Recogidas)
	labelColeccionables.text = str(Variables.Coleccionables)
