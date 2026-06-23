extends HBoxContainer

@export var ammo_slots: Array[TextureRect] = []  # drag all 8 in, in order, via the editor

func _ready() -> void:
	PlayerManager.ammo_changed.connect(_on_ammo_changed)
	_on_ammo_changed(PlayerManager.get_ammo_amt(), PlayerManager.get_max_ammo())

func _on_ammo_changed(current: int, max_ammo: int) -> void:
	for i in ammo_slots.size():
		ammo_slots[i].visible = i < current
