extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("jump")
	player.jump()


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	player.velocity.x += player.running_speed * input_direction_x
	player.velocity.y += player.get_own_gravity() * delta

	# When you reach the max jump height or released the jump button...
	if player.velocity.y >= 0.0 or Input.is_action_just_released("b_a"):
		var data_dict: Dictionary = {}
		# You're holding a time in air, and then start falling.
		if Input.is_action_just_released("b_a"):
			data_dict["cutted_jump"] = 0.1
		finished.emit(HOLDING_FALL, data_dict)
	
	player.move_and_slide()
