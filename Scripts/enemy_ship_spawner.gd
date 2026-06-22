#enemy ship spawner
extends Node

@export var enemy_ship_1: EnemyShip
@export var path_pos_1: PathFollow2D

@export var enemy_ship_2:EnemyShip
@export var path_pos_2:PathFollow2D

var move_speed:float = 0.1

var ship1_is_active:bool = false
var ship2_is_active:bool = false

func _ready():
	ship1_is_active = true
	ship2_is_active = true

func _process(delta):
	if ship1_is_active:
		move_ship(delta,path_pos_1)
	if ship2_is_active:
		move_ship(delta,path_pos_2)

func move_ship(dt:float,path:PathFollow2D):
	path.progress_ratio += move_speed * dt
