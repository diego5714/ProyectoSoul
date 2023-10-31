extends CharacterBody2D

@export var SPEED = 100
@export var GRAVITY = 1000
@export var ACCELERATION = 1500
@export var JUMP_SPEED = 700
var direction = Vector2.RIGHT
@onready var pivote = $Pivote
@onready var floor_ray = $Pivote/FloorRay
@onready var side_ray = $Pivote/SideRay

func _ready():
	$Walk_Animation.play("Walk")


func _physics_process(delta):
	velocity.x = move_toward(velocity.x, pivote.scale.x * SPEED, ACCELERATION*delta)
	
	if not is_on_floor():
		velocity.y += GRAVITY*delta
		
	if is_on_floor() and not floor_ray.is_colliding():
		pivote.scale.x *= -1
	if is_on_floor() and side_ray.is_colliding():
		pivote.scale.x *= -1
	move_and_slide()
	
