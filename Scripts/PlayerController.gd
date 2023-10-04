extends Node2D

@export var SPEED = 400
@export var GRAVITY = 1000
@export var ACCELERATION = 1500
@export var JUMP_SPEED = 500

@onready var PlayerA = $PlayerA
@onready var PlayerB = $PlayerB
@onready var timer = $Timer

var MaxJump = 2
var Jump = 0
var Sync = true #Modo Sync o modo Async
var Selected_A = true #Que jugador esta seleccionado para controlarlo en modo Async
var chocando = false
@export var Stamina = 15

func ColisionPared(player):
	return player.get_node("Pivote/RayCast2D").is_colliding()

func _ready():
	Variables.Stamina = Stamina

func _physics_process(delta):
	var move_input = Input.get_axis("izquierda","derecha")
	
	var StillPlayers = PlayerA.velocity == Vector2(0,0) and PlayerB.velocity == Vector2(0,0)
	
	if Input.is_action_just_pressed('desync') and StillPlayers:
		Sync = not Sync
		PlayerA.get_node("Label").set_text("Sync: " + str(Sync))
		PlayerB.get_node("Label").set_text("Sync: " + str(Sync))
		if Sync:
			timer.stop()
		else:
			timer.start()
		
	if Input.is_action_just_pressed('select_player'):
		Selected_A = not Selected_A
		PlayerA.get_node("Cursor").visible = Selected_A
		PlayerB.get_node("Cursor").visible = not Selected_A
		
	
	if Sync: #Modo sincronizado
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
				PlayerA.velocity.x = move_toward(PlayerA.velocity.x, 0, ACCELERATION * 2 * delta)
				PlayerB.velocity.x = move_toward(PlayerB.velocity.x, 0, ACCELERATION * 2 * delta)
		else: #Selected B
			PlayerA.parent_input = - move_input
			PlayerB.parent_input = move_input
			
			if not chocando:
				PlayerA.velocity.x = move_toward(PlayerA.velocity.x, - SPEED * move_input, ACCELERATION * delta)
				PlayerB.velocity.x = move_toward(PlayerB.velocity.x, SPEED * move_input, ACCELERATION * delta)
			else:
				PlayerA.velocity.x = move_toward(PlayerA.velocity.x, 0, ACCELERATION * 2 * delta)
				PlayerB.velocity.x = move_toward(PlayerB.velocity.x, 0, ACCELERATION * 2 * delta)
		
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
	pass


func _on_timer_timeout():
		Variables.Stamina -= 1
		
		if Variables.Stamina < 0:
			Sync = not Sync
			timer.stop()
			Variables.Stamina = Stamina
