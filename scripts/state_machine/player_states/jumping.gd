extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("jump")
	player.jump()


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	player.velocity.x = player.horizontal_speed * input_direction_x
	player.velocity.y += player.get_own_gravity() * delta

	if player.velocity.y >= 0.0 or Input.is_action_just_released("b_a"):
		print("QUIERES ENTRAR AQUÍ?!")
		finished.emit(HOLDING_FALL)
	
	player.move_and_slide()
