extends HBoxContainer

@onready var back = $Back
@onready var next = $Next
@onready var click_sound = $Click_Sound


var Click_Animation: bool = false

func _ready():
	back.set_deferred("disabled", false)
	back.pressed.connect(_on_back_pressed)
	back.mouse_entered.connect(_on_back_mouse_entered)
	back.mouse_exited.connect(_on_back_mouse_exited)
	
	next.set_deferred("disabled", false)
	next.pressed.connect(_on_next_pressed)
	next.mouse_entered.connect(_on_next_mouse_entered)
	next.mouse_exited.connect(_on_next_mouse_exited)

func _on_back_pressed():
	back.set_deferred("disabled", true)
	
	click_sound.play()
	%Back_Animations.play("Pushed")
	Click_Animation = true
	await %Back_Animations.animation_finished
	
	Variables.Current_Level = -1
	get_tree().change_scene_to_file("res://Scenes/UI/Level_Selector.tscn")

func _on_back_mouse_entered():
	if not Click_Animation:
		%Back_Animations.play("Hover")

func _on_back_mouse_exited():
	if not Click_Animation:
		%Back_Animations.play("RESET")

################################################################################

func _on_next_pressed():
	next.set_deferred("disabled", true)
	
	%Click_Sound.play()
	%Next_Animations.play("Pushed")
	Click_Animation = true
	await %Next_Animations.animation_finished

func _on_next_mouse_entered():
	if not Click_Animation:
		%Next_Animations.play("Hover")

func _on_next_mouse_exited():
	if not Click_Animation:
		%Next_Animations.play("RESET")
