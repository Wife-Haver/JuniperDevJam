extends Node

var _player_score:int = 0

signal score_increased(amt:int)

var HP_PICKUP_SCENE:PackedScene = preload("uid://riwf4u608bre")

func _ready():
	pass

func increase_score(amt:int)->void:
	_player_score += amt
	score_increased.emit(_player_score)

func set_player_score(newScore:int)->void:
	_player_score = newScore

func spawn_hp_pickup(pos: Vector2) -> void:
	var pickup: HealthPickup = HP_PICKUP_SCENE.instantiate()
	pickup.global_position = pos
	get_tree().current_scene.call_deferred("add_child", pickup)
