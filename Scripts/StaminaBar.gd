extends TextureProgressBar

@onready var label = $Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	label.set_text(str(Variables.Stamina))
	pass
