extends MarginContainer
@onready var cantidad = $Llaves/Cantidad

func _process(_delta):
	cantidad.text = str(Variables.Llaves_Recogidas)
