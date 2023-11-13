extends Node2D

var max_jump : int = 2
var SPEED : int = 400
var WARP_SPEED: int = 800
var GRAVITY: int = 1200
var ACCELERATION: int = 3000
var JUMP_SPEED: int = 500

var Stamina: float
var Sync: bool = true #Estado de sincronizacion de los personajes.
var Retorno: bool = false #Estado de warp de retorno

var NivelCargado: PackedScene
var MaxDepth: int

var Ganaste = false
var Fuerza_Platano: Vector2

var Llaves_Recogidas: int = 0

var Monedas: int = 0
