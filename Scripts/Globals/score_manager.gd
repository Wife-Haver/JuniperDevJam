extends Node

var _player_score:int = 0

signal score_increased(amt:int)

func _ready():
	pass

func increase_score(amt:int)->void:
	_player_score += amt
	score_increased.emit(_player_score)

func set_player_score(newScore:int)->void:
	_player_score = newScore
