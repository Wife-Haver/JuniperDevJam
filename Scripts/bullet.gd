class_name Bullet
extends Area2D

@export var speed: float = 600.0

# Set this at spawn time: true = fired by player, false = fired by an enemy.
var is_player_bullet: bool = true

var velocity: Vector2 = Vector2.ZERO

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	if is_player_bullet:
		sprite.play("player_bullet")	
	else:
		sprite.play("enemy_bullet")
	
	velocity = Vector2.RIGHT.rotated(rotation - PI/2) * speed

	#body_entered.connect(_on_body_entered)
	#area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	_handle_hit(body)

func _on_area_entered(area: Node2D) -> void:
	_handle_hit(area)

func _handle_hit(target: Node2D) -> void:
	if is_player_bullet:
		if target is Player:
			return
		if not (target is EnemyShip or target is Asteroid):
			return
	else:
		if not target is Player:
			return

	if target.has_method("hit"):
		target.hit()

	call_deferred("queue_free")
func _on_left_screen() -> void:
	call_deferred("queue_free")
