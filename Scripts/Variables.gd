extends Node2D

var Stamina: float
var Sync: bool = true #Estado de sincronizacion de los personajes.
var Retorno: bool = false #Estado de warp de retorno

var NivelCargado: PackedScene
var MaxDepth: int

var Ganaste = false
var Fuerza_Platano: Vector2

var Llaves_Recogidas: int = 0

var Monedas: int = 0
