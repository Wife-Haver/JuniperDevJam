extends Node
@export var clock_wise_1: AnimatedSprite2D
@export var clock_wise_2: AnimatedSprite2D
@export var not_clock_wise_1: AnimatedSprite2D
@export var not_clock_wise_2: AnimatedSprite2D

@export var player: Player

func _ready():
	player.switch_spin.connect(on_switch_spin)

func on_switch_spin(dir:int)->void:

	if dir == 1: #clockwise:
		clock_wise_1.visible = true
		clock_wise_2.visible = true
		
		not_clock_wise_1.visible = false
		not_clock_wise_2.visible = false
	else:
		
		clock_wise_1.visible = false
		clock_wise_2.visible = false
		
		not_clock_wise_1.visible = true
		not_clock_wise_2.visible = true
