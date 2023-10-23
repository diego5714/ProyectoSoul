#Este script solo se encarga de las animaciones
class_name Player
extends CharacterBody2D

@onready var animation_player := $AnimationPlayer
@onready var animation_tree := $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivote := $Pivote

var parent_input #input entregado por el CharacterController

func _ready():
	animation_tree.active = true

func _physics_process(_delta):
	var move_input = parent_input
	
	if move_input != 0:
		pivote.scale.x = sign(move_input)
		
	if is_on_floor():
		if abs(velocity.x) > 10 or move_input:
			playback.travel("Running")
		else:
			playback.travel("Idle")
	else:
		if velocity.y < 0:
			playback.travel("Jump")
		else:
			playback.travel("Falling")
			
func kill():
	animation_tree.set("parameters/conditions/dying", true)
	playback.travel("Dying")
	animation_tree.set("parameters/conditions/dying", false)
