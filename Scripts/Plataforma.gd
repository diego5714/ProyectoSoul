extends CharacterBody2D

var Moving: bool = false

@export var PosicionDer: Vector2 = self.position
var PosicionIzq: Vector2 = Vector2(PosicionDer.x - 735, PosicionDer.y)


func _on_llave_puerta_llave():
	Moving = true
	
func _on_timer_timeout():
	if Moving:
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, 'position', PosicionIzq, 3.0)
		tween.tween_property(self, 'position', PosicionDer, 3.0)
