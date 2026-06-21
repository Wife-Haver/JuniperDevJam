#player_manager
extends Node

var _current_hp:int = 10
var _max_hp:int = 10

signal update_current_hp
func _input(event):
	if Input.is_action_just_pressed("blah"):
		hurt_player(1)

func get_current_hp()->int:
	return _current_hp

func get_max_hp()->int:
	return _max_hp

func set_current_hp(newHP:int)->void:
	_current_hp = newHP
	update_current_hp.emit()

func set_max_hp(newHP:int)->void:
	_max_hp = newHP

func hurt_player(amt:int)->void:
	
	_current_hp -= amt
	update_current_hp.emit()
