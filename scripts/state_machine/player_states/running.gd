extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("muevete")
	player.animation_player.play("walk")

func physics_update(delta: float) -> void:
	print("pero muevete")
	var input_direction_x := Input.get_axis("d_left", "d_right")
	
	decide_sprite_side(input_direction_x)
	
	player.velocity.x = player.running_speed * input_direction_x
	player.velocity.y += player.get_own_gravity() * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("b_a"):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)


func decide_sprite_side(velx: float) -> void:
	if abs(velx) > 0:
		player.sprite_2d.flip_h = velx < 0
