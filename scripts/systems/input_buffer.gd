class_name InputBuffer
extends Node

signal input_consumed(input: String)

const NULL_COMAND = "NOTHING"

var buffer: Array[String] = []
var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.get_child_count() == 1, "You need a 1 timer!")
	timer = self.get_child(0)
	timer.ignore_time_scale = true
	timer.timeout.connect(_input_timeout)


func add_input(input: String):
	buffer.push_front(input)
	timer.start()
	


func get_input() -> String:
	if buffer.size() > 0:
		return buffer.back()
	return NULL_COMAND


func consume_input(input_expr: bool) -> bool:
	if input_expr:
		var consumed = buffer.pop_back()
		input_consumed.emit(consumed)
		# Still input in the buffer? Reset timer to cleanup.
		if buffer.size() > 0:
			timer.start()
		
		# Input is consumed.
		return true
	# Input is not consumed.
	return false


func _input_timeout():
	# Remove input for each timeout (even without input).
	buffer.pop_back()
	
	# Still have input? Restart timer again.
	if buffer.size() > 0:
		timer.start()
