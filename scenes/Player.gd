extends CharacterBody2D

#Variables:
@export var PERSONAJE = 1
@export var SPEED = 400
@export var GRAVITY = 800
@export var ACCELERATION = 1500
@export var JUMP_SPEED = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move_input = PERSONAJE * Input.get_axis("izquierda","derecha")
	
	if not is_on_floor():
		self.velocity.y += GRAVITY * delta
		
	if is_on_floor() and Input.is_action_pressed("saltar"):
		self.velocity.y -= JUMP_SPEED
	
	
	
	self.velocity.x = move_toward(self.velocity.x, SPEED * move_input, ACCELERATION * delta)
	
	move_and_slide()
	pass
