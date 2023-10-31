extends Node

var NivelCargado: PackedScene = Variables.NivelCargado
var MaxDepth: int = Variables.MaxDepth

func _ready():
	#Precargamos el nivel deseado y lo instanciamos
	var nivel := NivelCargado.instantiate()
	
	#Añadimos el nivel como hijo del primer viewport
	get_node("%ViewportA").add_child(nivel)
	
	#Definimos diccionario con la informacion de los nodos asociados a cada jugador
	var jugadores := {
	'1': {
		viewport = get_node("%ViewportA"),
		camera = get_node("%ViewportA/CamaraA"),
		player = get_node("%ViewportA/Nivel/CharacterController/PlayerA")
	},
	'2': {
		viewport = get_node("%ViewportB"),
		camera = get_node("%ViewportB/CamaraB"),
		player = get_node("%ViewportA/Nivel/CharacterController/PlayerB")
	}
}	
	#Tomamos el mundo 2D que renderiza el viewport A y se lo pasamos tambien al viewport B
	jugadores['2'].viewport.world_2d = jugadores['1'].viewport.world_2d
	
	
	#Iteramos a través de los nodos de cada jugador y mediante un RemoteTransform2D hacemos 
	#que la camara herede las propiedades del player. (Colocando el RemoteTransform como hijo del
	#jugador y haciendo que apunte hacia la camara.
	for nodo in jugadores.values():
		var transform := RemoteTransform2D.new()
		transform.remote_path = nodo.camera.get_path()
		nodo.player.add_child(transform)
		nodo.camera.limit_bottom = Variables.MaxDepth
		pass
	pass 
	
func _process(_delta):
	$CanvasLayer/Debug/VBoxContainer/Modo.set_text("Sync Mode (Q): " + str(get_node("%ViewportA/Nivel/CharacterController").Sync).to_pascal_case())
	
	var Selected_A : bool = get_node("%ViewportA/Nivel/CharacterController").Selected_A
	if Selected_A:
		$CanvasLayer/Debug/VBoxContainer/Personaje.set_text("Player (E): A")
	else:
		$CanvasLayer/Debug/VBoxContainer/Personaje.set_text("Player (E): B")
	pass
