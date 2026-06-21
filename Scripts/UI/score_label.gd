extends Label



func _ready():
	ScoreManager.score_increased.connect(_on_score_increase)

func _on_score_increase(amt:int):
	text = str(amt)
