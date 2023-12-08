extends Area2D

signal llave_recogida

@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	$Sprite_Animation.play("Shine")
	$Position_Animation.play("wobble")
	$Sprite2D.set_deferred("visible", true)
	
	collision_shape_2d.set_deferred("disabled", false)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.get_name() == "Player":
		collision_shape_2d.set_deferred("disabled", true)
		
		Variables.Llaves_Recogidas += 1
		
		$SFX/Key_Sound.play()
		$Sprite2D.set_deferred("visible", false)
		llave_recogida.emit()
		
		await $SFX/Key_Sound.finished
		queue_free()
