extends PlayerState

var holding_timer: Timer

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass


## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass


## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	var input_x_dir := Input.get_axis("d_left", "d_right")
	player.velocity.x = player.horizontal_speed * input_x_dir
	player.velocity.y = 0

		


func holding_time_timeout():
	finished.emit(FALLING)

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	holding_timer = Timer.new()
	holding_timer.wait_time = player.peak_time
	holding_timer.autostart = true
	add_child(holding_timer)
	holding_timer.start()
	holding_timer.timeout.connect(holding_time_timeout)


## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
