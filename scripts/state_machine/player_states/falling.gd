extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("que me caigo!")
	
	
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	
	player.velocity.x = input_direction_x * player.horizontal_speed
	player.velocity.y += player.get_own_gravity() * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
	#player.velocity.y += player.gravity * delta
	#player.move_and_slide()
	#var input_direction_x := Input.get_axis("move_left", "move_right")
	#player.velocity.x = player.speed * input_direction_x
#
	#player.velocity.y += player.gravity * delta
	#player.move_and_slide()
#
	#if Input.is_action_just_pressed("glide"):
		#finished.emit(GLIDING)
	#elif player.is_on_floor():
		#if is_equal_approx(player.velocity.x, 0.0):
			#finished.emit(IDLE)
		#else:
			#finished.emit(RUNNING)
