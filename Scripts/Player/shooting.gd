extends Node

const BULLET_SCENE = preload("uid://o37sfangb3tt")
@export var gun_barrel: Marker2D
@export var player: Player

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		fire()

func fire():
	var bullet:Bullet = BULLET_SCENE.instantiate()
	bullet.global_position = gun_barrel.global_position
	bullet.rotation = player.rotation
	get_tree().current_scene.add_child(bullet)
