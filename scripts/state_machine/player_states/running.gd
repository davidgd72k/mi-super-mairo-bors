extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree["parameters/playback"].travel("Running")
	
	if previous_state_path == FALLING:
		var anima_tree = player.animation_tree
		anima_tree.set("parameters/Running/AddFall/add_amount", 1.0)

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	
	decide_sprite_side(input_direction_x)
	
	player.velocity.x = player.running_speed * input_direction_x
	player.velocity.y += player.get_own_gravity() * delta
	
	if Input.is_action_pressed("b_b"):
		player.velocity.x *= 3.0

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("b_a"):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
		
	player.move_and_slide()


func decide_sprite_side(velx: float) -> void:
	if abs(velx) > 0:
		player.sprite_2d.flip_h = velx < 0
