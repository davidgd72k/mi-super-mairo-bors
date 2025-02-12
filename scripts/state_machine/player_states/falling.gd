extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree["parameters/playback"].travel("Fall")


func exit() -> void:
	print("deberia chafarme contra el suelo")
	player.animation_tree["parameters/playback"].travel("InGround")
	player.play_squashing_animation()

	
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	
	player.velocity.x = player.running_speed * input_direction_x
	player.velocity.y += player.get_own_gravity() * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
