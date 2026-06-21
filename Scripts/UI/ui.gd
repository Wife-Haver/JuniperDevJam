extends Control

@export var progress_bar: ProgressBar

@export var score_label: Label

func _ready():
	progress_bar.max_value = PlayerManager.get_max_hp()
	progress_bar.value = PlayerManager.get_current_hp()
	PlayerManager.update_current_hp.connect(_on_player_hurt)
	
	ScoreManager.score_increased.connect(_on_score_increase)

func _on_player_hurt():
	progress_bar.max_value = PlayerManager.get_max_hp()
	progress_bar.value = PlayerManager.get_current_hp()
	if progress_bar.value <= 0:
		ScreenManager.end_game()

func _on_score_increase(amt:int):
	score_label.text = str(amt)
