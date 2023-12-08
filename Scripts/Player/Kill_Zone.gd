extends Area2D

func _physics_process(_delta):
	var lista = get_overlapping_bodies()
	
	for body in lista:
		if body.get_name() == "Player":
			body.kill()
