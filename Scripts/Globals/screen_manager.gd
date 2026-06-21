extends Node

const GAME_OVER_SCREEN:PackedScene = preload("uid://c11o24a0dbucq")
const MAIN_SCENE:PackedScene = preload("uid://do7l3vsqxf4lj")

#signal game_over
#signal game_start

func end_game()->void:
	get_tree().change_scene_to_packed(GAME_OVER_SCREEN)

func start_game()->void:
	get_tree().change_scene_to_packed(MAIN_SCENE)

func restart_stats()->void:
	PlayerManager.set_max_hp(10)
	PlayerManager.set_current_hp(10)
