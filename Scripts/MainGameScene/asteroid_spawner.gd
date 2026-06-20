extends Node

const ASTEROID_SCENE:PackedScene = preload("uid://rp1gatnvo3vh")
@export var spawner_pos: PathFollow2D

func _on_timeout():
	spawn_asteroid()

func spawn_asteroid():
	var asteroid:Asteroid = ASTEROID_SCENE.instantiate()
	spawner_pos.progress_ratio = randf()
	
	asteroid.position = spawner_pos.position
	
	var direction = spawner_pos.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	
	var velocity = Vector2(randf_range(100.0, 200.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	add_child(asteroid)
