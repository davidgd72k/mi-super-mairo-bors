extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	print("empezamos quietos")
	player.velocity.x = 0.0
	player.animation_player.play("idle")


func physics_update(_delta: float) -> void:
	#player.velocity.y += player.get_gravity().y * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("b_a"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("d_left") or Input.is_action_pressed("d_right"):
		finished.emit(RUNNING)
