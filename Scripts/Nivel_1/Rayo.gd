extends Area2D

@onready var animaciones_rayo = $Animaciones_Rayo
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_sonido = $"../Area_Sonido"
@onready var sonido_rayo = $Sonido_Rayo
@onready var timer = $Timer


func _ready():
	set_deferred("monitoring", true)	
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func _on_timer_timeout():
	timer.stop()
	animaciones_rayo.play("Rayo")
	
	if area_sonido.player_inside:
		sonido_rayo.play()
		
	
	await animaciones_rayo.animation_finished
	timer.start()

func _on_body_entered(body):
	if body.get_name() == "Player":
		body.damage(1)
