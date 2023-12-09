extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var flores = $".."

func _ready():
	flores.grown_now.connect(_on_flowers_grown_now)

func _on_flowers_grown_now():
	animation_player.play("Growing")
