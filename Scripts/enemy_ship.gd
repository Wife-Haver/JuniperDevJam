class_name EnemyShip
extends Area2D

@export var player: Player
@export var animation_player: AnimationPlayer
@export var collision_shape: CollisionShape2D  # assign in the editor

const BULLET_SCENE: PackedScene = preload("uid://o37sfangb3tt")

@export var fire_interval: float = 1.5
@export var bullet_speed: float = 400.0

var max_hp: int = 3
var hp: int = 3
var score_value: int = 50

var _fire_timer: Timer = null

signal ship_destroyed(ship: EnemyShip)

func _ready() -> void:
	_fire_timer = Timer.new()
	_fire_timer.wait_time = fire_interval
	add_child(_fire_timer)
	_fire_timer.timeout.connect(_fire_at_player)

	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

	add_to_group("enemy")

	# Start "off" until the spawner activates it.
	despawn()

func _process(_delta: float) -> void:
	if player:
		look_at(player.position)

func spawn() -> void:
	hp = max_hp
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	set_process(true)
	if collision_shape:
		collision_shape.set_deferred("disabled",false)
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	_fire_timer.start()

func despawn() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	set_process(false)
	if collision_shape:
		#collision_shape.disabled = true
		collision_shape.set_deferred("disabled",true)
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	if _fire_timer:
		_fire_timer.stop()
	

func hit() -> void:
	if hp <= 0:
		return

	hp -= 1
	animation_player.play("hit")

	if hp <= 0:
		ScoreManager.spawn_hp_pickup(global_position)
		_die()

func _die() -> void:
	ScoreManager.increase_score(score_value)
	ship_destroyed.emit(self)
	despawn()

func _fire_at_player() -> void:
	if player == null or not is_instance_valid(player):
		return

	var angle_to_player = (player.global_position - global_position).angle()

	var bullet = BULLET_SCENE.instantiate()
	bullet.is_player_bullet = false
	bullet.speed = bullet_speed
	bullet.global_position = global_position
	bullet.rotation = angle_to_player + PI / 2  # compensate for bullet.gd's -PI/2 velocity correction

	get_tree().current_scene.add_child(bullet)

func _on_body_entered(body: Node2D) -> void:
	_handle_player_collision(body)

func _on_area_entered(area: Node2D) -> void:
	_handle_player_collision(area)

func _handle_player_collision(target: Node2D) -> void:
	if target.is_in_group("player"):
		PlayerManager.hurt_player(1)
		_die()
