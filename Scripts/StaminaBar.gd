extends TextureProgressBar

@onready var timer = $Timer
@export var MAX: int = 15

func _ready():
	self.max_value = MAX
	timer.start()
	
func _process(delta):
	self.value = Variables.Stamina
