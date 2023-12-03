extends StaticBody2D
#var mostrar = false
#
#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
#@onready var tile_map: TileMap = $TileMap
#@onready var puente: StaticBody2D = $"."
#
#func _ready():
#	#collision_shape_2d.set_deferred("disabled",true)
#	#tile_map.set_deferred("collision_visibility_mode",2)
#	puente.set_collision_layer_value(1,false)
#	puente.set_collision_mask_value(1,false)
#
#	self.hide()
#
#func _process(_delta: float) -> void:
#	collision_and_show()
#
#func collision_and_show():
#	if mostrar == true:
#		self.show()
#		puente.set_collision_layer_value(1,true)
#		puente.set_collision_mask_value(1,true)
#
#
#
#func _on_button_button_pushed() -> void:
#	mostrar = true
#
var mostrar = false
var posicion = Vector2(-1984,416)

@onready var puente_llama: StaticBody2D = $Puente



	
func _on_button_button_pushed() -> void:
	if (mostrar == true):
		instanciar_puente()
		mostrar = false
	
func instanciar_puente():
	if puente_llama != null:
		puente_llama.queue_free()
	var puente = load("res://Scenes/Props/Puente_Normal.tscn").instantiate()
	self.add_child(puente)
	puente.global_position=posicion
	puente.scale= Vector2(2,2)
	
	


	
