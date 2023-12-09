extends Area2D

func _ready():
	pass 

func _process(_delta):
	pass

func _on_button_2b_button_pushed():
	queue_free()

func _on_body_entered(body):
	if body.get_name() == "Player":
		pass 
