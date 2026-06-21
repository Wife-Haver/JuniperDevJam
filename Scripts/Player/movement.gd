extends Node
@export var player: Player

var rotate_speed:float = 2.5
 
var spin_direction: int = 1  # 1 = clockwise, -1 = counterclockwise

func _physics_process(delta):
	rotate(delta)

func rotate(delta):
	player.rotation += rotate_speed * spin_direction * delta

func _unhandled_input(event):
	if event.is_action_pressed("flip_spin"):
		spin_direction *= -1
