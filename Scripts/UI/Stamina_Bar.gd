extends TextureProgressBar

@export var MAX: float = 12.0
var iniciando = true

var valor := MAX:
	set(valorBruto):
		var val: float = clamp(valorBruto, 0, MAX)
		value = val
		
func _ready():
	self.max_value = MAX

func _physics_process(_delta):
	valor = Variables.Stamina
