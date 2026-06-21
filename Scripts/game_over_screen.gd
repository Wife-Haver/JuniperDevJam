extends Control

const MAIN_SCENE:PackedScene = preload("res://Scenes/main.tscn")


func _on_restart_btn_pressed():
	get_tree().change_scene_to_packed(MAIN_SCENE)
