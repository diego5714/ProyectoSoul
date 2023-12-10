extends Area2D
@onready var fuego_sonido = $Fuego

func _ready():
	body_entered.connect(activar_sonido)
	
func activar_sonido():
	fuego_sonido.play().set_pann(-1)
	
