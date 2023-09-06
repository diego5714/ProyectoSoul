class_name Player
extends CharacterBody2D

#Variables:
@export var PERSONAJE = 1
@export var SPEED = 400
@export var GRAVITY = 1000
@export var ACCELERATION = 1500
@export var JUMP_SPEED = 700

var MaxJump = 2
var Jump = 0

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivote = $Pivote

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move_input = PERSONAJE * Input.get_axis("izquierda","derecha")
	
	if is_on_floor():
		Jump=0
	if not is_on_floor():
		self.velocity.y += GRAVITY * delta
		
	if Input.is_action_just_pressed("saltar") and Jump<MaxJump:
		self.velocity.y -= JUMP_SPEED
		Jump+=1
	
	self.velocity.x = move_toward(self.velocity.x, SPEED * move_input, ACCELERATION * delta)
	
	move_and_slide()
	
	if move_input != 0:
		pivote.scale.x = sign(move_input)
		
	if is_on_floor():
		if abs(velocity.x)>10 or move_input:
			playback.travel("run")
		else:
			playback.travel("Idle")
	else:
		if velocity.y < 0:
			playback.travel("Jump")
		else:
			playback.travel("fall")
