class_name Player_Controller
extends Node2D

signal muerte_sync
signal muerte_async

@onready var Pair_Animations: AnimationPlayer = $Pair_Animations

@export var SPEED: int = 400 
@export var WARP_SPEED: int = 800
@export var GRAVITY: int = 1200
@export var ACCELERATION: int = 3000
@export var JUMP_SPEED: int = 500
@export var MAX_JUMP: int = 2
var Jump: int = 0

var constants: PackedInt32Array = PackedInt32Array()


@export var pos_inicial_a: Marker2D
@export var pos_inicial_b: Marker2D

var current_cp: Vector2

var selected_a : bool = true #Que jugador esta seleccionado para controlarlo en modo Async

@onready var A: Player = %Player_A
@onready var B: Player = %Player_B
@onready var timer : Timer = $Timer
@onready var humoA = $Player_A/humoA
@onready var humoB = $Player_B/humoB

@export var MaxStamina: float = 12.0 #Segundos de duracion 
@onready var music = $Music

###################################################################################################
#Definicion de funciones auxiliares

func animate_pair(move_input: float):
	if selected_a:
		if move_input != 0:
			A.pivote.scale.x = sign(move_input)
			B.pivote.scale.x = sign(-move_input)
	
		if A.player.is_on_floor():
			if abs(A.player.velocity.x) > 10 or move_input:
				A.playback.travel("Running")
				B.playback.travel("Running")
			else:
				A.playback.travel("Idle")
				B.playback.travel("Idle")
		
		else:
			if A.player.velocity.y < 0:
				A.playback.travel("Jump")
				B.playback.travel("Jump")
				if Input.is_action_just_pressed('saltar'):
					humoA.set_position(A.player.position)
					humoB.set_position(B.player.position)
					humoA.humo()
					humoB.humo()
			else:
				A.playback.travel("Falling")
				B.playback.travel("Falling")
	
	else:
		if move_input != 0:
			A.pivote.scale.x = sign(-move_input)
			B.pivote.scale.x = sign(move_input)
	
		if B.player.is_on_floor():
			if abs(B.player.velocity.x) > 10 or move_input:
				A.playback.travel("Running")
				B.playback.travel("Running")
			else:
				A.playback.travel("Idle")
				B.playback.travel("Idle")
		
		else:
			if B.player.velocity.y < 0:
				A.playback.travel("Jump")
				B.playback.travel("Jump")
				if Input.is_action_just_pressed('saltar'):
					humoA.set_position(A.player.position)
					humoB.set_position(B.player.position)
					humoA.humo()
					humoB.humo()
			else:
				A.playback.travel("Falling")
				B.playback.travel("Falling")

func set_current_cp(cp):
	if cp.x > 0:
		cp.x = -cp.x
	
	current_cp = cp

func kill():
	Variables.current_health = 0
	Debug.dprint("KILL-ZONE")

func damage(value):
	var current = Variables.current_health
	current -= value
	if current < 0:
		current = 0
	
	Variables.current_health = current

###################################################################################################

func _ready():
	music.play()
	constants.append(SPEED)
	constants.append(ACCELERATION)
	constants.append(WARP_SPEED)
	constants.append(GRAVITY)
	constants.append(JUMP_SPEED)
	constants.append(MAX_JUMP)

	Variables.Stamina = MaxStamina
	timer.wait_time = MaxStamina
	
	muerte_sync.connect(_on_sync_killed)
	muerte_async.connect(_on_async_killed)

	A.player.set_position(pos_inicial_a.position)
	B.player.set_position(pos_inicial_b.position)
	
	current_cp = pos_inicial_a.get_global_position()

	A.get_cursor().visible = true
	B.get_cursor().visible = false

func _physics_process(delta):
	var move_input: float = Input.get_axis("izquierda","derecha")

	var Still_Players: bool = A.is_velocity_zero() \
							and B.is_velocity_zero() \
							and not Variables.Retorno

	#Primero chequeamos cambio a modo sincronizado
	if Input.is_action_just_pressed("desync"):
		if Variables.Sync:
			if Still_Players:
				Variables.Sync = false

				if selected_a:
					A.toggle_ghost(true)
				else:
					B.toggle_ghost(true)

				timer.start()

		else: 
			Variables.Sync = true
			timer.stop()
			
			Variables.Retorno = true
			
			if selected_a:
				A.velocity_to_zero('x,y')
				A.retorno_ghost()
				
			else:
				B.velocity_to_zero('x,y')
				B.retorno_ghost()

	if Input.is_action_just_pressed('select_player'):
		if Variables.Sync:
			selected_a = not selected_a
			A.get_cursor().visible = selected_a
			B.get_cursor().visible = not selected_a


   #############################################################################
	
	if Variables.Sync: #Estado Sync
		Variables.Stamina = lerp(Variables.Stamina, MaxStamina, 0.04)
		
		if Variables.current_health == 0:
			if not Variables.Muerte:
				Variables.Retorno = true
				Variables.Muerte = true
			
				Debug.dprint("Signal Sync")
				muerte_sync.emit()
		
		if not Variables.Retorno:
			if selected_a:
				if not B.is_raycast_colliding("Lateral"):
					A.horizontal_update(delta, move_input, constants)
					
				else:
					A.velocity_to_zero('x')
					B.velocity_to_zero('x')

				A.vertical_update(delta, constants)
				B.vertical_update(delta, constants)

				animate_pair(move_input)

				A.player.move_and_slide()
				B.player.move_and_slide()
				B.player.position.x = -1 * A.get_current_pos().x

			else:
				if not A.is_raycast_colliding("Lateral"):
					B.horizontal_update(delta, move_input, constants)
					
				else:
					A.velocity_to_zero('x')
					B.velocity_to_zero('x')
				
				B.vertical_update(delta, constants)
				A.vertical_update(delta, constants)

				animate_pair(move_input)
				
				A.player.move_and_slide()
				B.player.move_and_slide()
				A.player.position.x = -1 * B.get_current_pos().x


	else: #Estado Async
		if Variables.current_health == 0:
			if not Variables.Muerte:
				Variables.Retorno = true
				Variables.Muerte = true
			
				Debug.dprint("Signal Async")
				muerte_async.emit()
		
		if not Variables.Retorno:
			Variables.Stamina -= delta

			if selected_a:
				A.animate(move_input)
				A.full_async_move(delta, move_input, constants)
				pass

			else:
				B.animate(move_input)
				B.full_async_move(delta, move_input, constants)
				pass


####################################################################################################
#Signals:

func _on_timer_timeout():
		Variables.Sync = true
		timer.stop()

		Variables.Retorno = true
		if selected_a:
			A.velocity_to_zero('x,y')
			A.retorno_ghost()

		else:
			B.velocity_to_zero('x,y')
			B.retorno_ghost()

func _on_sync_killed():
	A.animation_tree.set_deferred("active", false)
	B.animation_tree.set_deferred("active", false)
	
	Pair_Animations.play("Dying")
	await Pair_Animations.animation_finished
	
	#Pair_Animations.play("RESET")
	
	A.animation_tree.set_deferred("active", true)
	B.animation_tree.set_deferred("active", true)
	
	A.velocity_to_zero("x,y")
	B.velocity_to_zero("x,y")
	
	A.player.position = current_cp
	B.player.position = Vector2(-1, 1) * current_cp
	
	Variables.current_health = 3
	Variables.Muerte = false
	
	Variables.Retorno = false
	Variables.Sync = true
	
	

func _on_async_killed():
	A.animation_tree.set_deferred("active", false)
	B.animation_tree.set_deferred("active", false)
	
	Pair_Animations.play("Dying")
	await Pair_Animations.animation_finished
	
	#Pair_Animations.play("RESET")
	
	A.animation_tree.set_deferred("active", true)
	B.animation_tree.set_deferred("active", true)
	
	if selected_a:
		A.toggle_ghost(false)
		A.velocity_to_zero("x,y")
		A.player.position = current_cp
	
	else:
		B.toggle_ghost(false)
		B.velocity_to_zero("x,y")
		B.player.position = Vector2(-1, 1) * current_cp
	
	timer.stop()
	
	Variables.current_health = 3
	Variables.Muerte = false
	
	Variables.Retorno = false
	Variables.Sync = true
