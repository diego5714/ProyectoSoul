
class_name Player
extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var ghost: Sprite2D = $Ghost

@onready var animation_player : AnimationPlayer = player.get_node("AnimationPlayer")
@onready var animation_tree := player.get_node("AnimationTree")
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivote := player.get_node("Pivote")

var jump: int = 0

################################################################################
#Funciones auxiliares

func is_raycast_colliding(direccion: String):
	return pivote.get_node("RayCast" + direccion).is_colliding()

func no_collisions(estado: bool):
	player.set_collision_layer_value(1, not estado)
	player.set_collision_mask_value(1, not estado)
	player.set_collision_mask_value(2, not estado)
	player.set_collision_mask_value(3, not estado)
	player.set_collision_mask_value(4, not estado)
	
func toggle_ghost(estado: bool):
		ghost.visible = estado
		if estado:
			ghost.position = player.position

func velocity_to_zero(eje: String):
	assert(eje in ['x','y','x,y'], 'Direccion no valida')
	if eje == 'x':
		player.velocity.x = 0
	elif eje == 'y':
		player.velocity.y = 0
	elif eje == 'x,y':
		player.velocity = Vector2.ZERO

func retornar():
		var ReturnPoint: Vector2 = Ghost.position - Vector2(0, 30)
		no_collisions(true)
	
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(player, 'position', ReturnPoint, 1.2)
	
		tween.finished.connect(
			func():
				no_collisions(false)
				toggle_ghost(false)
				Player.position = ReturnPoint
				Variables.Retorno = false
				)

func async_move(delta, move_input):
	if player.is_on_floor():
		jump = 0
	else:
		player.velocity.y += Variables.GRAVITY * delta
		
		if Input.is_action_just_pressed("saltar") and jump < Variables.max_jump:
			player.velocity.y -= Variables.JUMP_SPEED
			jump += 1
			
		velocity_to_zero('x')
		player.velocity.x = move_toward(player.velocity.x, Variables.SPEED * move_input, Variables.ACCELERATION * delta)

func kill():
	pass

################################################################################

func _ready():
	await get_tree().create_timer(0.5).timeout #Fix para el bug de frame out of bounds
	ghost.visible = false
	animation_tree.active = true
	pass

func _physics_process(_delta):
	var move_input = Input.get_axis("izquierda", "derecha")
	
	if move_input != 0:
		pivote.scale.x = sign(move_input)
		
	if player.is_on_floor():
		if abs(player.velocity.x) > 10 or move_input:
			playback.travel("Running")
		else:
			playback.travel("Idle")
	else:
		if player.velocity.y < 0:
			playback.travel("Jump")
		else:
			playback.travel("Falling")
			

