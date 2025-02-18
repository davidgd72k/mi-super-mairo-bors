extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	
	var anim_tree = player.animation_tree
	var state_machine = anim_tree["parameters/playback"]
	
	if previous_state_path == null:
		state_machine.travel("InGround")
	else:
		anim_tree.set("parameters/InGround/BlendWalking/blend_amount", 0.0)


func physics_update(_delta: float) -> void:
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif player.is_on_floor():
		if input_buffer.consume_input(input_buffer.get_input() == BUTTON_A):
			finished.emit(JUMPING)
		elif Input.is_action_pressed("d_left") or Input.is_action_pressed("d_right"):
			finished.emit(RUNNING)


func apply_falling_effect_to_anim(applying: bool):
	var anima_tree: AnimationTree = player.animation_tree
	anima_tree.set("parameters/Idle/AddFall/add_amount", 1.0 if applying else 0.0)


func do_recovering_animation(applying: bool):
	var state_machine = player.animation_tree["parameters/playback"]
	if applying:
		state_machine.travel("Idle")
	else:
		state_machine.travel("Recovering")
		state_machine.travel("Idle")
