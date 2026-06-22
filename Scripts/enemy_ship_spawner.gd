extends Node

@export var enemy_ship_1: EnemyShip
@export var path_pos_1: PathFollow2D

@export var enemy_ship_2: EnemyShip
@export var path_pos_2: PathFollow2D

var move_speed: float = 0.1

var ship1_is_active: bool = false
var ship2_is_active: bool = false

@export var timer: Timer

func _ready() -> void:
	# Make sure both ships start despawned/hidden until explicitly activated.
	enemy_ship_1.despawn()
	enemy_ship_2.despawn()

	# Listen for each ship dying so we can mark it inactive again
	# and stop moving it along its path.
	enemy_ship_1.ship_destroyed.connect(_on_ship_destroyed.bind(1))
	enemy_ship_2.ship_destroyed.connect(_on_ship_destroyed.bind(2))

	timer.wait_time = 10.0
	timer.one_shot = true
	#timer.timeout.connect(_on_timer_timeout)

	# Kick off the very first spawn cycle.
	timer.start()
	
	

func _process(delta: float) -> void:
	if ship1_is_active:
		move_ship(delta, path_pos_1)
	if ship2_is_active:
		move_ship(delta, path_pos_2)

func move_ship(dt: float, path: PathFollow2D) -> void:
	path.progress_ratio += move_speed * dt

func _any_ship_active() -> bool:
	return ship1_is_active or ship2_is_active

# Call this anytime to spawn/activate ship 1 (e.g. from a wave timer, trigger zone, etc).
func activate_ship_1() -> void:
	if ship1_is_active:
		return
	path_pos_1.progress_ratio = 0.0
	enemy_ship_1.spawn()
	ship1_is_active = true

# Call this anytime to spawn/activate ship 2.
func activate_ship_2() -> void:
	if ship2_is_active:
		return
	path_pos_2.progress_ratio = 0.0
	enemy_ship_2.spawn()
	ship2_is_active = true

# Generic helper if you don't care which slot, just want "any free ship spawned".
# Returns true if a ship was activated, false if one was already active.
func activate_any() -> bool:
	if _any_ship_active():
		return false

	if not ship1_is_active:
		activate_ship_1()
		return true
	elif not ship2_is_active:
		activate_ship_2()
		return true
	return false

func _on_ship_destroyed(_ship: EnemyShip, slot: int) -> void:
	if slot == 1:
		ship1_is_active = false
	elif slot == 2:
		ship2_is_active = false

	# Only start the wait countdown once no enemies remain active.
	if not _any_ship_active():
		timer.start()

func _on_timer_timeout() -> void:
	call_deferred("activate_any")
