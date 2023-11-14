class_name CharacterController
extends Node2D

@export var SPEED: int = 400
@export var WARP_SPEED: int = 800
@export var GRAVITY: int = 1200
@export var ACCELERATION: int = 3000
@export var JUMP_SPEED: int = 500
@export var Pos_Inicial_A: Marker2D
@export var Pos_Inicial_B: Marker2D

@onready var PlayerA := $PlayerA
@onready var PlayerB := $PlayerB
@onready var GhostA := $GhostA
@onready var GhostB := $GhostB
@onready var timer := $Timer

const MaxJump: int = 2
var Jump: int = 0
var Sync := true #Modo Sync o modo Async
var Selected_A := true #Que jugador esta seleccionado para controlarlo en modo Async
var C_pared := false #Colision con paredes simultanea
var C_techo := false #Colision con techo simultaneo

@export var MaxStamina: float = 5.0 #Segundos de duracion 

###################################################################################################
#Definicion de funciones custom:

func ReturnDead(player):
	VelocityToZero(PlayerA, 'x,y', false, 1)
	VelocityToZero(PlayerB,'x,y', false, 1)
	
	NoColisiones(PlayerA, true)
	NoColisiones(PlayerB, true)
	Variables.Retorno = true
		
	if Selected_A:
		retornar(player, GhostA, true)
	else:
		retornar(player, GhostB, true)

func isRaycastColliding(nodo, direccion: String):
	return nodo.get_node("Pivote/RayCast" + direccion).is_colliding()
	
func NoColisiones(player: CharacterBody2D, estado: bool):
	player.set_collision_layer_value(1, not estado)
	player.set_collision_mask_value(1, not estado)
	player.set_collision_mask_value(2, not estado)
	player.set_collision_mask_value(3, not estado)
	player.set_collision_mask_value(4, not estado)
	
func ToggleGhost(ghost: Ghost, estado: bool):
		ghost.visible = estado
		if estado:
			ghost.position = ghost.belongs_to.position
		
func VelocityToZero(player: Player, eje: String, interpolado: bool, delta: float):
	assert(eje in ['x','y','x,y'], 'Direccion no valida')
	if eje == 'x':
		if interpolado:
			player.velocity.x = move_toward(player.velocity.x, 0, ACCELERATION * delta)
		else:
			player.velocity.x = 0
	elif eje == 'y':
		if interpolado:
			player.velocity.y = move_toward(player.velocity.y, 0, ACCELERATION * delta)
		else:
			player.velocity.y = 0
	elif eje == 'x,y':
		if interpolado:
			player.velocity.x = move_toward(player.velocity.x, 0, ACCELERATION * delta)
			player.velocity.y = move_toward(player.velocity.y, 0, ACCELERATION * delta)
		else:
			player.velocity = Vector2.ZERO
			
func retornar(Player, Ghost, muerte: bool):
	VelocityToZero(Player, 'x,y', false, 1)
	
	if not muerte:
		var ReturnPoint: Vector2 = Ghost.position - Vector2(0, 30)
	
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(Player, 'position', ReturnPoint, 1.2)
	
		tween.finished.connect(
			func():
			NoColisiones(Player,false)
			ToggleGhost(Ghost, false)
			Player.position = ReturnPoint
			Variables.Retorno = false
			)
	else:
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(PlayerA, 'position', Pos_Inicial_A.position, 1.2)
		tween.parallel().tween_property(PlayerB, 'position', Pos_Inicial_B.position, 1.2)
		
		tween.finished.connect(
			func():
			NoColisiones(PlayerA, false)
			NoColisiones(PlayerB, false)
			PlayerA.position = Pos_Inicial_A.position
			PlayerB.position = Pos_Inicial_B.position
			Variables.Retorno = false
			)
	

###################################################################################################

func _ready():
	Variables.Stamina = MaxStamina
	timer.wait_time = MaxStamina
	
	PlayerA.position = Pos_Inicial_A.position
	PlayerB.position = Pos_Inicial_B.position

func _physics_process(delta):
	var move_input := Input.get_axis("izquierda","derecha")
	
	var StillPlayers : bool = PlayerA.velocity.is_equal_approx(Vector2.ZERO) and PlayerB.velocity.is_equal_approx(Vector2.ZERO) and not Variables.Retorno
	
	if Input.is_action_just_pressed('desync'):
		if Sync:
			if StillPlayers:
				Sync = false
				if Selected_A:
					ToggleGhost(GhostA, true)
				else:
					ToggleGhost(GhostB, true)
				
				timer.start()
		else:
			Sync = true
			timer.stop()
			
			Variables.Retorno = true
			if Selected_A:
				retornar(PlayerA, GhostA, false)
				Debug.dprint("A se devuelve")
			else:
				retornar(PlayerB,GhostB, false)
				Debug.dprint("B se devuelve")
			
			
	if Input.is_action_just_pressed('select_player'):
		if Sync:
			Selected_A = not Selected_A
			PlayerA.get_node("Cursor").visible = Selected_A
			PlayerB.get_node("Cursor").visible = not Selected_A
	
	
	if Sync: #Modo sincronizado
		if not Variables.Retorno: 
			Variables.Stamina = lerp(Variables.Stamina, MaxStamina, 0.04)
			ToggleGhost(GhostA, false)
			ToggleGhost(GhostB, false)
			
			if PlayerA.is_on_floor() and PlayerB.is_on_floor():
				Jump = 0
			else:
				PlayerA.velocity.y += GRAVITY * delta
				PlayerB.velocity.y += GRAVITY * delta
	
			if Input.is_action_just_pressed("saltar") and Jump < MaxJump:
				PlayerA.velocity.y -= JUMP_SPEED
				PlayerB.velocity.y -= JUMP_SPEED
				Jump += 1
			
			C_techo = isRaycastColliding(PlayerA, 'Superior') or isRaycastColliding(PlayerB, 'Superior')
			
			if C_techo:
				PlayerA.velocity.y += JUMP_SPEED * 0.5
				PlayerB.velocity.y += JUMP_SPEED * 0.5
		
			C_pared = isRaycastColliding(PlayerA, 'Lateral') or isRaycastColliding(PlayerB, 'Lateral')
			
			if Selected_A:
				PlayerA.parent_input = move_input
				PlayerB.parent_input = - move_input
			
				if not C_pared:
					PlayerA.velocity.x = move_toward(PlayerA.velocity.x, SPEED * move_input, ACCELERATION * delta)
					PlayerB.velocity.x = move_toward(PlayerB.velocity.x, - SPEED * move_input, ACCELERATION * delta)
				else:
					VelocityToZero(PlayerA, 'x', false, delta)
					VelocityToZero(PlayerB, 'x', false, delta)
			else: #Selected B
				PlayerA.parent_input = - move_input
				PlayerB.parent_input = move_input
			
				if not C_pared:
					PlayerA.velocity.x = move_toward(PlayerA.velocity.x, - SPEED * move_input, ACCELERATION * delta)
					PlayerB.velocity.x = move_toward(PlayerB.velocity.x, SPEED * move_input, ACCELERATION * delta)
				else:
					VelocityToZero(PlayerA, 'x', false, delta)
					VelocityToZero(PlayerB, 'x', false, delta)
				
		PlayerA.move_and_slide()
		PlayerB.move_and_slide()
	
	else: #Modo desincronizado
		
		Variables.Stamina -= delta
		
		if Selected_A:
			PlayerA.parent_input = move_input
			PlayerB.parent_input = 0
			if PlayerA.is_on_floor():
				Jump = 0
			else:
				PlayerA.velocity.y += GRAVITY * delta
		
			if Input.is_action_just_pressed("saltar") and Jump < MaxJump:
				PlayerA.velocity.y -= JUMP_SPEED
				Jump += 1
	
			PlayerA.velocity.x = move_toward(PlayerA.velocity.x, SPEED * move_input, ACCELERATION * delta)
			VelocityToZero(PlayerB, 'x', false, delta)
		else:
			PlayerA.parent_input = 0
			PlayerB.parent_input = move_input
			if PlayerB.is_on_floor():
				Jump = 0
			else:
				PlayerB.velocity.y += GRAVITY * delta
		
			if Input.is_action_just_pressed("saltar") and Jump < MaxJump:
				PlayerB.velocity.y -= JUMP_SPEED
				Jump += 1
			
			VelocityToZero(PlayerA, 'x', false, delta)
			PlayerB.velocity.x = move_toward(PlayerB.velocity.x, SPEED * move_input, ACCELERATION * delta)
		
		PlayerA.move_and_slide()
		PlayerB.move_and_slide()
	
	#CheckDead(PlayerA)
	#CheckDead(PlayerB)

####################################################################################################
#Signals:

func _on_timer_timeout():
		Sync = true
		timer.stop()
		
		Variables.Retorno = true
		if Selected_A:
			Debug.dprint("A se devuelve")
			retornar(PlayerA, GhostA, false)
		else:
			Debug.dprint("B se devuelve")
			retornar(PlayerB,GhostB, false)
