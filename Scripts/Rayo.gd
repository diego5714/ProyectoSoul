extends Area2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var playback = animation_tree.get("parameters/playback")
@onready var collision_shape_2d = $CollisionShape2D
@onready var lightning = $Lightning

func _ready():
	set_deferred("monitoring", true)
	#collision_shape_2d.set_deferred("disabled", false)
	
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	#collision_shape_2d.set_deferred("disabled", true)
	
	if body.get_name() == "Player":
		Debug.dprint("damage")
		print("damage")
#func _ready() -> void:
	##$CollisionShape2D.set_deferred("disabled",true)
	#animation_tree.active = true
	#
	#
#
#func _on_body_entered(body):
	#if (body.get_name()=="Player"):
		#Debug.log("Damage")
		#print("damage")
	#
