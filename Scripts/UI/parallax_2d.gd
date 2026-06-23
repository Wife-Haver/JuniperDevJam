
extends Parallax2D

@export var scroll_speed: Vector2 = Vector2(50, 0)  # pixels/sec, direction your bg should drift

func _process(delta: float) -> void:
	scroll_offset += scroll_speed * delta
