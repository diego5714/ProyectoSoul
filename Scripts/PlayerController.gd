extends Node2D

@export var SPEED: int = 400
@export var GRAVITY: int = 1000
@export var ACCELERATION: int = 3000
@export var JUMP_SPEED: int = 500

@onready var PlayerA := $PlayerA
@onready var PlayerB := $PlayerB
@onready var return_pos_A := $Return_Pos_A
@onready var return_pos_B := $Return_Pos_B
@onready var GhostA := $Return_Pos_A/GhostA
@onready var GhostB := $Return_Pos_B/GhostB
@onready var timer := $Timer

const MaxJump: int = 2
var Jump: int = 0
var Sync := true #Modo Sync o modo Async
var Selected_A := true #Que jugador esta seleccionado para controlarlo en modo Async
var chocando := false

@export var Stamina: int = 5
var retorno: bool = false
var tween_finished: bool = false

func ColisionPared(player):
	return player.get_node("Pivote/RayCast2D").is_colliding()
	
func SetearFantasma(player: CharacterBody2D, estado: bool):
	player.set_collision_layer_value(1, not estado)
	PlayerA.set_collision_layer_value(6, estado)
	player.set_collision_mask_value(1, not estado)
	player.set_collision_mask_value(2, not estado)
	player.set_collision_mask_value(3, not estado)
	player.set_collision_mask_value(4, not estado)
	

func _ready():
	Variables.Stamina = Stamina

func _physics_process(delta):
	var move_input := Input.get_axis("izquierda","derecha")
	
	var StillPlayers : bool = PlayerA.velocity == Vector2(0,0) and PlayerB.velocity == Vector2(0,0)
	
	if Input.is_action_just_pressed('desync') and StillPlayers:
		Sync = not Sync
		
		if Selected_A:
			GhostA.visible = true
			return_pos_A.position = PlayerA.position
		else:
			GhostB.visible = true
			return_pos_B.position = PlayerB.position
		
		if Sync:
			timer.stop()
		else:
			timer.start()
		
	if Input.is_action_just_pressed('select_player'):
		if Sync:
			Selected_A = not Selected_A
			PlayerA.get_node("Cursor").visible = Selected_A
			PlayerB.get_node("Cursor").visible = not Selected_A
		
	
	if Sync: #Modo sincronizado
		if not retorno: 
			if PlayerA.is_on_floor() and PlayerB.is_on_floor():
				Jump = 0
			else:
				PlayerA.velocity.y += GRAVITY * delta
				PlayerB.velocity.y += GRAVITY * delta
		
			if Input.is_action_just_pressed("saltar") and Jump < MaxJump:
				PlayerA.velocity.y -= JUMP_SPEED
				PlayerB.velocity.y -= JUMP_SPEED
				Jump += 1
		
			chocando = ColisionPared(PlayerA) or ColisionPared(PlayerB)
		
			if Selected_A:
				PlayerA.parent_input = move_input
				PlayerB.parent_input = - move_input
			
				if not chocando:
					PlayerA.velocity.x = move_toward(PlayerA.velocity.x, SPEED * move_input, ACCELERATION * delta)
					PlayerB.velocity.x = move_toward(PlayerB.velocity.x, - SPEED * move_input, ACCELERATION * delta)
				else:
					PlayerA.velocity.x = move_toward(PlayerA.velocity.x, 0, ACCELERATION * delta)
					PlayerB.velocity.x = move_toward(PlayerB.velocity.x, 0, ACCELERATION * delta)
			else: #Selected B
				PlayerA.parent_input = - move_input
				PlayerB.parent_input = move_input
			
				if not chocando:
					PlayerA.velocity.x = move_toward(PlayerA.velocity.x, - SPEED * move_input, ACCELERATION * delta)
					PlayerB.velocity.x = move_toward(PlayerB.velocity.x, SPEED * move_input, ACCELERATION * delta)
				else:
					PlayerA.velocity.x = move_toward(PlayerA.velocity.x, 0, ACCELERATION * delta)
					PlayerB.velocity.x = move_toward(PlayerB.velocity.x, 0, ACCELERATION * delta)
		
		else: #Modo retorno
			var tween := create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
			#tween.set_speed_scale(2.0)
			tween.connect('finished', on_tween_finished)
			
			if Selected_A:
				SetearFantasma(PlayerA, true)
				GhostA.visible = false
				tween.tween_property(PlayerA, 'position', return_pos_A.position - Vector2(0,20), 3.0)
			else:
				SetearFantasma(PlayerB, true)
				GhostB.visible = false
				tween.tween_property(PlayerB, 'position', return_pos_B.position - Vector2(0, 20), 3.0)
			
			
		PlayerA.move_and_slide()
		PlayerB.move_and_slide()
	
	else: #Modo desincronizado
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
			PlayerB.velocity.x = move_toward(PlayerB.velocity.x, 0, ACCELERATION * 2 * delta)
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
			
			PlayerA.velocity.x = move_toward(PlayerA.velocity.x, 0, ACCELERATION * 2 * delta)
			PlayerB.velocity.x = move_toward(PlayerB.velocity.x, SPEED * move_input, ACCELERATION * delta)
		
		PlayerA.move_and_slide()
		PlayerB.move_and_slide()
		
	Debug.dprint(PlayerA.velocity.y == 0.0)
		
	if Variables.Stamina < 0:
			Sync = not Sync
			Variables.Stamina = Stamina
			timer.stop()
			
			if Selected_A:
				Debug.dprint("A se devuelve")
				retorno = true
			else:
				Debug.dprint("B se devuelve")
				retorno = true

func _on_timer_timeout():
		Variables.Stamina -= 1

		
func on_tween_finished():
		
	if Selected_A:
		SetearFantasma(PlayerA, false)
	else:
		SetearFantasma(PlayerB, false)
		
	retorno = false
