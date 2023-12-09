extends Area2D

func _ready():
	pass 

func _process(_delta):
	pass

func _on_body_entered(body):
	if body.get_name() == "Player":
		pass

func _on_button_4b_button_pushed():
	queue_free()
	
