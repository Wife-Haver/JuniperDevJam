class_name Asteroid
extends RigidBody2D

var _rotate_speed:float = 2.0
 
var _spin_direction: int = 1  # 1 = clockwise, -1 = counterclockwise

var score_value:int = 10

var _dmg_amt:int = 1

func _ready():
	_rotate_speed = randi_range(1,3)
	_spin_direction = [-1, 1].pick_random()
	angular_velocity = _rotate_speed * _spin_direction

func _hit_player():
	PlayerManager.hurt_player(_dmg_amt)

func _on_player_entered(body:Node2D):
	if body is Player:
		_hit_player()
		queue_free()

func _on_screen_exit():
	queue_free()
