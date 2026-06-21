extends ProgressBar




func _ready():
	max_value = PlayerManager.get_max_hp()
	value = PlayerManager.get_current_hp()
	PlayerManager.update_current_hp.connect(_on_player_hurt)

func _on_player_hurt():
	max_value = PlayerManager.get_max_hp()
	value = PlayerManager.get_current_hp()
	if value <= 0:
		ScreenManager.end_game()
