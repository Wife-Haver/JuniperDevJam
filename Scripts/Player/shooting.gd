extends Node

const BULLET_SCENE = preload("uid://o37sfangb3tt")
@export var gun_barrel: Marker2D
@export var player: Player
@export var shoot_cooldown_timer: Timer       # fire-rate cooldown, already existed
@export var recharge_delay_timer: Timer       # one-shot, 2s, assign in editor
@export var recharge_tick_timer: Timer        # repeating, e.g. 0.5s, assign in editor

var can_shoot: bool = true

func _ready() -> void:
	recharge_delay_timer.one_shot = true
	recharge_delay_timer.timeout.connect(_on_recharge_delay_timeout)

	recharge_tick_timer.one_shot = false
	recharge_tick_timer.timeout.connect(_on_recharge_tick_timeout)

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot:
		if fire():
			can_shoot = false
			shoot_cooldown_timer.start()

			# Player just fired — cancel any in-progress recharge and
			# restart the 2-second idle countdown.
			recharge_tick_timer.stop()
			recharge_delay_timer.start()

func fire() -> bool:
	if not PlayerManager.use_ammo():
		return false

	var bullet: Bullet = BULLET_SCENE.instantiate()
	bullet.global_position = gun_barrel.global_position
	bullet.rotation = player.rotation
	bullet.is_player_bullet = true
	get_tree().current_scene.add_child(bullet)
	return true

func _on_shoot_cd_timeout() -> void:
	can_shoot = true

func _on_recharge_delay_timeout() -> void:
	# 2 seconds of no firing have passed — begin the gradual trickle recharge.
	recharge_tick_timer.start()

func _on_recharge_tick_timeout() -> void:
	PlayerManager.add_ammo()
	if PlayerManager.get_ammo_amt() >= PlayerManager.get_max_ammo():
		recharge_tick_timer.stop()
