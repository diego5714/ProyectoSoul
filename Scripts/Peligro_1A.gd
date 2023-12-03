extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_button_2b_button_pushed():
	queue_free()
	pass # Replace with function body.





func _on_body_entered(body):
	if body.get_name() == "Player":
		pass # Replace with function body.
