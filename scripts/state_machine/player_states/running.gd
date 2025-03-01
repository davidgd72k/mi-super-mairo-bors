extends PlayerState

var falling_timer: Timer

func enter(previous_state_path: String, data := {}) -> void:
	var anim_tree = player.animation_tree
	anim_tree.set("parameters/InGround/BlendWalking/blend_amount", 1.0)
	
	falling_timer = Timer.new()
	falling_timer.wait_time = 0.5
	add_child(falling_timer)
	falling_timer.timeout.connect(_falling_timer_timeout)


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("d_left", "d_right")
	
	decide_sprite_side(input_direction_x)
	
	player.velocity.x = player.running_speed * input_direction_x
	player.velocity.y += player.get_gravity().y * delta
	
	if Input.is_action_pressed("b_b"):
		player.velocity.x *= 3.0

	player.apply_floor_snap()
	player.move_and_slide()

	if player.is_on_floor():
		if input_buffer.consume_input(input_buffer.get_input() == BUTTON_A):
			finished.emit(JUMPING)
		elif is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
	elif not player.is_on_floor():
		finished.emit(FALLING)
	
	


func decide_sprite_side(velx: float) -> void:
	if abs(velx) > 0:
		player.sprite_2d.flip_h = velx < 0


func apply_falling_effect_to_anim(applying: bool):
	var anima_tree: AnimationTree = player.animation_tree
	anima_tree.set("parameters/Running/AddFall/add_amount", 1.0 if applying else 0.0)


func do_recovering_animation(applying: bool):
	var state_machine = player.animation_tree["parameters/playback"]
	if applying:
		state_machine.travel("Running")
	else:
		state_machine.travel("Recovering")
		state_machine.travel("Running")


func _falling_timer_timeout():
	finished.emit(FALLING)
