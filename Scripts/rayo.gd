extends StaticBody2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var playback = animation_tree.get("parameters/playback")


func _ready() -> void:
	animation_tree.active = true
