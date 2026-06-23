extends Node
@export var player: Player

var rotate_speed:float = 2.5
 
var spin_direction: int = 1  # 1 = clockwise, -1 = counterclockwise

@export var thruster_anim: AnimatedSprite2D



func _physics_process(delta):
	rotate(delta)
	
	if Input.is_action_just_pressed("flip_spin"):
		spin_direction *= -1
		player.switch_spin.emit(spin_direction)

func rotate(delta):
	player.rotation += rotate_speed * spin_direction * delta
