extends MarginContainer

@onready var resume = %Resume
@onready var retry = %Retry
@onready var menu = %Main_Menu
@onready var exit = %Exit

@export var menu_scene : PackedScene
var Click_Animation: bool = false

func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	resume.mouse_entered.connect(_on_resume_mouse_entered)
	resume.mouse_exited.connect(_on_resume_mouse_exited)
	%Resume_Animations.play("RESET")
	
	retry.pressed.connect(_on_retry_pressed)
	retry.mouse_entered.connect(_on_retry_mouse_entered)
	retry.mouse_exited.connect(_on_retry_mouse_exited)
	%Retry_Animations.play("RESET")
	
	menu.pressed.connect(_on_menu_pressed)
	menu.mouse_entered.connect(_on_menu_mouse_entered)
	menu.mouse_exited.connect(_on_menu_mouse_exited)
	%Menu_Animations.play("RESET")
	
	exit.pressed.connect(_on_exit_pressed)
	exit.mouse_entered.connect(_on_exit_mouse_entered)
	exit.mouse_exited.connect(_on_exit_mouse_exited)
	%Exit_Animations.play("RESET")
	
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	%Click_Sound.play()
	%Resume_Animations.play("Pushed")
	Click_Animation = true
	await %Resume_Animations.animation_finished
	
	hide()
	get_tree().paused = false
	%Resume_Animations.play("RESET")
	Click_Animation = false
	
func _on_retry_pressed():
	%Click_Sound.play()
	%Retry_Animations.play("Pushed")
	Click_Animation = true
	await %Retry_Animations.animation_finished
	
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func _on_menu_pressed():
	%Click_Sound.play()
	%Menu_Animations.play("Pushed")
	Click_Animation = true
	await %Menu_Animations.animation_finished
	
	if not menu_scene:
		return
	get_tree().change_scene_to_packed(menu_scene)
	get_tree().paused = false
	
func _on_exit_pressed():
	%Click_Sound.play()
	%Exit_Animations.play("Pushed")
	Click_Animation = true
	await %Exit_Animations.animation_finished
	
	get_tree().quit()
	
################################################################################

func _on_resume_mouse_entered():
	if not Click_Animation:
		%Resume_Animations.play("Hover")

func _on_resume_mouse_exited():
	if not Click_Animation:
		%Resume_Animations.play("RESET")

################################################################################
func _on_retry_mouse_entered():
	if not Click_Animation:
		%Retry_Animations.play("Hover")
	
func _on_retry_mouse_exited():
	if not Click_Animation:
		%Retry_Animations.play("RESET")

################################################################################
func _on_menu_mouse_entered():
	if not Click_Animation:
		%Menu_Animations.play("Hover")
	
func _on_menu_mouse_exited():
	if not Click_Animation:
		%Menu_Animations.play("RESET")

################################################################################
func _on_exit_mouse_entered():
	if not Click_Animation:
		%Exit_Animations.play("Hover")
	
func _on_exit_mouse_exited():
	if not Click_Animation:
		%Exit_Animations.play("RESET")
