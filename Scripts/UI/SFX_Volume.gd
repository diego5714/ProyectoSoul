extends VBoxContainer

@onready var label = $Label
@onready var h_slider = $HSlider
var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index("SFX")
	h_slider.value_changed.connect(_on_value_changed)
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	label.text = "SFX Volume: " + str(h_slider.value * 100) + "%"

func _on_value_changed(value: float):
	label.text = "SFX Volume: " + str(value * 100) + "%"
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
