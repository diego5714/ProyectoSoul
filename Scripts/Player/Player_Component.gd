extends CharacterBody2D
class_name Player_Component

@onready var player_controller: Player_Controller = $"../.."

func kill():
	player_controller.kill()

func set_current_cp(cp):
	player_controller.set_current_cp(cp)

func damage(value):
	player_controller.damage(value)
