extends Node2D

@export var SPEED: int = 400
@export var WARP_SPEED: int = 800
@export var GRAVITY: int = 1200
@export var ACCELERATION: int = 3000
@export var JUMP_SPEED: int = 500

@export var pos_inicial_a: Marker2D
@export var pos_inicial_b: Marker2D

var Selected_A : bool = true #Que jugador esta seleccionado para controlarlo en modo Async
@onready var player_a : Player = %Player_A
@onready var player_b : Player = %Player_B
@onready var timer : Timer = $Timer

@export var max_jump: int = 2
var Jump: int = 0

var C_pared : bool = false #Colision con paredes simultanea
var C_techo : bool = false #Colision con techo simultaneo

@export var MaxStamina: float = 5.0 #Segundos de duracion 

###################################################################################################
#Definicion de funciones auxiliares

func retornar_ambos():
	player_a.velocity_to_zero('x,y')
	player_b.velocity_to_zero('x,y')
	
	player_a.no_collisions(true)
	player_b.no_collisions(true)
	
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(player_a, 'position', pos_inicial_a.position, 1.2)
	tween.parallel().tween_property(player_b, 'position', pos_inicial_b.position, 1.2)
		
	tween.finished.connect(
		func():
			player_a.no_collisions(false)
			player_b.no_collisions(false)
			player_a.position = pos_inicial_a.position
			player_b.position = pos_inicial_b.position
			Variables.Retorno = false
			)

###################################################################################################

func _ready():
	Variables.SPEED = SPEED
	Variables.ACCELERATION = ACCELERATION
	Variables.WARP_SPEED = WARP_SPEED
	Variables.GRAVITY = GRAVITY
	Variables.JUMP_SPEED = JUMP_SPEED
	Variables.max_jump = max_jump
	
	
	Variables.Stamina = MaxStamina
	timer.wait_time = MaxStamina
	
	player_a.position = pos_inicial_a.position
	player_b.position = pos_inicial_b.position

func _physics_process(delta):
	var move_input := Input.get_axis("izquierda","derecha")
	var Still_Players: bool = player_a.player.velocity.is_equal_approx(Vector2.ZERO) \
							and player_b.player.velocity.is_equal_approx(Vector2.ZERO) \
							and not Variables.Retorno
	
	#Primero chequeamos cambio a modo sincronizado
	if Input.is_action_just_pressed("desync"):
		if Variables.Sync and Still_Players:
			Variables.Sync = false
			
			timer.start()
		
		else: 
			Variables.Sync = true
			timer.stop()
			
			Variables.Retorno = true
			
	if Input.is_action_just_pressed('select_player'):
		if Variables.Sync:
			Selected_A = not Selected_A
			player_a.get_node("Cursor").visible = Selected_A
			player_b.get_node("Cursor").visible = not Selected_A
	
   #############################################################################
	
	if Variables.Sync:
		if not Variables.Retorno: #Estado Sync
			pass
		
	else: #Estado Desync
		pass


####################################################################################################
#Signals:

func _on_timer_timeout():
		Variables.Sync = true
		timer.stop()
		
		Variables.Retorno = true
		if Selected_A:
			Debug.dprint("A se devuelve")
			player_a.retornar()
		else:
			Debug.dprint("B se devuelve")
			player_b.retornar()
