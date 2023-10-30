extends StaticBody2D
var mostrar = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var tile_map: TileMap = $TileMap

func _ready():
	#collision_shape_2d.set_deferred("disabled",true)
	#tile_map.set_deferred("collision_visibility_mode",2)
	
	self.hide()
	
func _process(_delta: float) -> void:
	collision_and_show()
	
func collision_and_show():
	if mostrar == true:
		self.show()
		self.set_collision_layer_value(1,true)


func _on_button_button_pushed() -> void:
	mostrar = true
	
