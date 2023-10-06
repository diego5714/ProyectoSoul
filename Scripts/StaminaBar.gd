extends TextureProgressBar

@onready var timer = $Timer
@export var MAX: int = 15
var count = 0

func _ready():
	self.max_value = MAX
	timer.start()

func _on_timer_timeout():
	if not Variables.Sync:
		self.value = Variables.Stamina
	
	else:
		count += 1
		if count == 2:
			var tween = self.create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(self, 'value', float(MAX), 2.0)
			count = 0
