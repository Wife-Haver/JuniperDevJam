class_name EnemyShip
extends Area2D

@export var player:Player
@export var animation_player: AnimationPlayer

var score_value:int = 50
var hp:int = 3

func hit():
	if hp <= 0:
		return
	else:
		hp -= 1
		animation_player.play("hit")

func _process(delta):
	look_at(player.position)
