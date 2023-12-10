extends Control

@onready var label = $MarginContainer/PanelContainer/VSplitContainer/MarginContainer2/VBoxContainer/MarginContainer/Label
@onready var timer = $MarginContainer/PanelContainer/VSplitContainer/MarginContainer2/VBoxContainer/MarginContainer/Timer

var text = ''
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.02

func _ready():
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.lenght():
		return
		
	match text[letter_index]:
		"!",".",",","?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

func _on_timer_timeout():
	_display_letter()
