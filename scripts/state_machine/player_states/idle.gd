extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	print("empezamos quietos")
	player.velocity.x = 0.0
	
	if previous_state_path == FALLING:
		# Mezcla al 100% la animación de escala
		print("haz la mezcla YA")
		player.animation_tree.set("parameters/OneShot/active", true)
		# Play child animation connected to "shot" port.
		player.animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		
		
	 
	#else: 
		#player.animation_tree["parameters/playback"].travel("idle")
	#player.animation_player.play("")


func physics_update(_delta: float) -> void:
	#player.velocity.y += player.get_gravity().y * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("b_a"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("d_left") or Input.is_action_pressed("d_right"):
		finished.emit(RUNNING)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "recovering_from_fall":
		player.animation_player.play("idle")
