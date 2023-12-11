extends CheckBox

var fullscreen: bool = false

func _ready():
	pressed.connect(_on_check_pressed)

func _on_check_pressed():
	if not fullscreen:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
