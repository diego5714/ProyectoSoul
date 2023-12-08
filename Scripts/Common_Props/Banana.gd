extends RigidBody2D

func _ready():
	self.linear_velocity = Variables.Fuerza_Platano

func _physics_process(_delta):
	if self.position.y >= 2500:
		self.queue_free()
