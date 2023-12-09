extends MarginContainer

@onready var tutorial_info_label = $MarginContainer/PanelContainer/MarginContainer/Tutorial_Info_Label
var max_index = 14

func _ready():
	Variables.Textos_Tutorial.append("Welcome to the tutorial level!!, Feel free to move forward.")
	Variables.Textos_Tutorial.append("As you can see, your characters move in sync with each other.")
	
	Variables.Textos_Tutorial.append("There are platforms blocking your way")
	Variables.Textos_Tutorial.append("You can select your primary character for movement by pressing E.")
	Variables.Textos_Tutorial.append("This allows you to choose which character follows your input directly.")
	Variables.Textos_Tutorial.append("If you press Q while standing still...")
	Variables.Textos_Tutorial.append("You can enter Asynchronous movement mode...")
	Variables.Textos_Tutorial.append("Or just Async for short.")
	Variables.Textos_Tutorial.append("In this mode, you leave your ghost behind...")
	Variables.Textos_Tutorial.append("and as a result, you can move your selected character independently.")
	Variables.Textos_Tutorial.append("But be carefull, your stamina bar is going to deplete.")
	Variables.Textos_Tutorial.append("And you will be warped right back where you pressed Q.")
	Variables.Textos_Tutorial.append("You can also cancel this mode by just pressing Q again.")
	Variables.Textos_Tutorial.append("Now, try going Async with your blue character...")
	Variables.Textos_Tutorial.append("And press the button at the other side of the abyss.")
	
	tutorial_info_label.text = Variables.Textos_Tutorial[Variables.current_tutorial_text]
	
	if Variables.Textos_Visibles:
		self.set_deferred("visible", true)
	else:
		self.set_deferred("visible", false)
	
func _process(_delta):
	if Input.is_action_just_pressed("Test") and not max_index == Variables.current_tutorial_text:
		Variables.current_tutorial_text += 1
	
	tutorial_info_label.text = Variables.Textos_Tutorial[Variables.current_tutorial_text]
	
