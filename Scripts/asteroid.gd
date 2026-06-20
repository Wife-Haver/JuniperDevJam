class_name Asteroid
extends RigidBody2D

var rotate_speed:float = 2.0
 
var spin_direction: int = 1  # 1 = clockwise, -1 = counterclockwise

func _ready():
	rotate_speed = randi_range(1,3)
	spin_direction = [-1, 1].pick_random()
	angular_velocity = rotate_speed * spin_direction

#func _physics_process(delta):
	#rotate_sprite(delta)
#
#func rotate_sprite(delta):
	#rotation += rotate_speed * spin_direction * delta
#



func _on_screen_exit():
	queue_free()
