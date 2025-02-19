extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree["parameters/playback"].travel("Fall")
	
	if previous_state_path == RUNNING or previous_state_path == IDLE:
		player.coyote = true
		(player.get_node("CoyoteTimer") as Timer).start()


func exit() -> void:
	player.animation_tree["parameters/playback"].travel("InGround")
	player.play_squashing_animation()

	
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	
	player.velocity.x = player.running_speed * input_direction_x
	player.velocity.y += player.get_own_gravity() * delta
	player.move_and_slide()
	
	if Input.is_action_just_pressed("b_a") and player.coyote:
		print("COYOTING TIME")
		finished.emit(JUMPING)
	
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
		
