class_name Bullet
extends Area2D

@export var speed: float = 600.0
@export var lifetime: float = 2.0  # seconds before auto-destroy, prevents bullets flying forever offscreen

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# parent sets rotation
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
	
	queue_free()

func _on_left_screen():
	queue_free()
