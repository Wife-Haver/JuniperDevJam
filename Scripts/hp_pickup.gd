class_name HealthPickup
extends Sprite2D

var player:Player
var player_pos:Vector2

var travel_time:float = 2.0
var heal_amount:int = 1

var _tween:Tween = null

func _ready():
	
	player_pos = Vector2(320,320)
	
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.set_ease(Tween.EASE_IN)
	_tween.tween_property(self, "global_position", player_pos, travel_time)
	_tween.finished.connect(_on_arrived)
	
func _on_arrived() -> void:
	# Guard against this firing twice (once from tween.finished, once from
	# the lifetime safety timer) after the node is already gone.
	if not is_instance_valid(self) or is_queued_for_deletion():
		return
 
	PlayerManager.heal_player(heal_amount)
	queue_free()
