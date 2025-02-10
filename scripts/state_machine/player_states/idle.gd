extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	print("empezamos quietos")
	player.velocity.x = 0.0
	
	var state_machine = player.animation_tree["parameters/playback"]
	state_machine.travel("Idle")
	
	apply_falling_effect_to_anim(previous_state_path == FALLING)
		

func apply_falling_effect_to_anim(applying: bool):
	var anima_tree: AnimationTree = player.animation_tree
	anima_tree.set("parameters/Idle/AddFall/add_amount", 1.0 if applying else 0.0)

func physics_update(_delta: float) -> void:
	#player.velocity.y += player.get_gravity().y * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("b_a"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("d_left") or Input.is_action_pressed("d_right"):
		finished.emit(RUNNING)
