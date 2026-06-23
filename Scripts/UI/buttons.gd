extends HBoxContainer

func _input(event):
	if Input.is_action_just_pressed("flip_spin"):
		print("flipped")

func on_swap_spin_button_down():
	Input.action_press("flip_spin")

func on_swap_spin_button_up():
	Input.action_release("flip_spin")




func _on_shoot_button_down():
	Input.action_press("shoot")


func _on_shoot_button_up():
	Input.action_release("shoot")
