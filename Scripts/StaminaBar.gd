extends TextureProgressBar

@onready var label = $Label
@onready var timer = $Timer
@export var MAX: int = 15

func _ready():
	self.max_value = MAX
	timer.start()
	
func _process(delta):
	label.set_text(str(Variables.Stamina))
	self.value = Variables.Stamina
