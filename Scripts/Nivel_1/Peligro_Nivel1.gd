extends Area2D

@onready var sonido_peligro = $Sonido_Peligro
@onready var timer = $Timer


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	timer.timeout.connect(_on_timer_timeout)
	

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		Debug.dprint("ADENTRO")
		sonido_peligro.play()
		timer.start()

func _on_body_exited(body: Node2D):
	if body.get_name() == "Player":
		timer.stop()

func _on_timer_timeout():
	sonido_peligro.play()
	Debug.dprint("TIMER")
