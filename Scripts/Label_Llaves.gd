extends MarginContainer
@onready var label = %Label_Numero

func _process(_delta):
	label.text = str(Variables.Llaves_Recogidas)
