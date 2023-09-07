extends MarginContainer

@onready var resume = %Resume
@onready var retry = %retry
@onready var menu = %"Main Menu"
@onready var exit = %Exit

@export var menu_scene : PackedScene

func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	menu.pressed.connect(_on_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	hide()
	get_tree().paused = false
	
	
	
	
	
func _on_retry_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func _on_menu_pressed():
	if not menu_scene:
		return
	get_tree().change_scene_to_packed(menu_scene)
	get_tree().paused = false
	
func _on_exit_pressed():
	get_tree().quit()
