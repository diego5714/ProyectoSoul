extends Node2D

var max_jump : int = 2
var current_health: int = 3

var Stamina: float
var Sync: bool = true #Estado actual de los personajes (Sync, Async)
var Retorno: bool = false
var Muerte: bool = false

var NivelCargado: PackedScene
var MaxDepth: int

var Ganaste: bool = false
var Fuerza_Platano: Vector2

var Llaves_Recogidas: int = 0

var Monedas: int = 0
var Coleccionables: int = 0

var current_tutorial_text: int = 0
var Textos_Tutorial: Array = []
var Textos_Visibles: bool = true

var gamestarted = false
var gatos = 0
var selector = false
