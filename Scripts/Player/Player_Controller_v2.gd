class_name Player_Controller
extends Node2D


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

@export var MaxStamina: float = 12.0 #Segundos de duracion 
@onready var music = $"Music(Provisorio)/Music"

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
			else:
				A.playback.travel("Falling")
				B.playback.travel("Falling")

func set_current_cp(cp):
	if cp.x > 0:
		cp.x = -cp.x
	
	current_cp = cp

func kill():
	Debug.dprint("Te moristes wey")
	A.velocity_to_zero('x,y')
	A.retorno_muerte(current_cp - Vector2(0, 40))
	
	B.velocity_to_zero('x,y')
	B.retorno_muerte((current_cp * Vector2(-1, 1)) - Vector2(0, 40))

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

	A.player.set_position(pos_inicial_a.position)
	B.player.set_position(pos_inicial_b.position)

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
				Debug.dprint("A se devuelve")
				A.velocity_to_zero('x,y')
				A.retorno_ghost()
			else:
				Debug.dprint("B se devuelve")
				B.velocity_to_zero('x,y')
				B.retorno_ghost()

	if Input.is_action_just_pressed('select_player'):
		if Variables.Sync:
			selected_a = not selected_a
			A.get_cursor().visible = selected_a
			B.get_cursor().visible = not selected_a


   #############################################################################
	
	if Variables.Sync:
		Variables.Stamina = lerp(Variables.Stamina, MaxStamina, 0.04)

		if not Variables.Retorno: #Estado Sync
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
			
			#Debug.dprint(abs(A.player.position.x + B.player.position.x))


	else: #Estado Desync
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
			Debug.dprint("A se devuelve")
			A.velocity_to_zero('x,y')
			A.retorno_ghost()

		else:
			Debug.dprint("B se devuelve")
			B.velocity_to_zero('x,y')
			B.retorno_ghost()
