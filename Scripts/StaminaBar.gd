extends TextureProgressBar

@onready var timer := $Timer
@export var MAX: int = 5
var valor := MAX:
	set(valorBruto):
		var val: int = clamp(valorBruto, 0, MAX)
		var tween := create_tween()
		tween.tween_property(self, 'value', float(val), 0.5)

func _ready():
	self.max_value = MAX
	timer.start()
	
func _on_timer_timeout():
	valor = Variables.Stamina
