#player_manager
extends Node

var _current_hp:int = 10
var _max_hp:int = 10
var _max_ammo: int = 8
var _player_ammo:int = 8

signal update_current_hp
signal player_was_hurt
signal ammo_changed(current: int, max: int)
signal player_fired

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

func heal_player(amt:int)->void:
	if _current_hp >= _max_hp:
		return
	else:
		_current_hp += amt
	update_current_hp.emit()

func hurt_player(amt:int)->void:
	_current_hp -= amt
	update_current_hp.emit()
	player_was_hurt.emit()

func get_max_ammo() -> int:
	return _max_ammo

func set_max_ammo(newMaxAmmo: int) -> void:
	_max_ammo = newMaxAmmo
	ammo_changed.emit(_player_ammo, _max_ammo)

func set_ammo(newAmmo: int) -> void:
	_player_ammo = newAmmo
	ammo_changed.emit(_player_ammo, _max_ammo)

func use_ammo() -> bool:
	if _player_ammo <= 0:
		return false
	_player_ammo -= 1
	player_fired.emit()
	ammo_changed.emit(_player_ammo, _max_ammo)
	return true

func get_ammo_amt()->int:
	return _player_ammo

func add_ammo() -> void:
	if _player_ammo >= _max_ammo:
		return
	_player_ammo += 1
	ammo_changed.emit(_player_ammo, _max_ammo)
