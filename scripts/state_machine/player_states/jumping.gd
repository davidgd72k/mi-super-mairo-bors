extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.peak_height = player.get_peak_height()
	player.velocity.y = player.jump_velocity


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	player.velocity.x = player.horizontal_speed * input_direction_x

	player.velocity.y += player.get_own_gravity() * delta
	player.move_and_slide()


	if player.is_peak_height_reach():
		finished.emit(HOLDING_FALL)
	
	if player.velocity.y >= 0.0:
		finished.emit(FALLING)
