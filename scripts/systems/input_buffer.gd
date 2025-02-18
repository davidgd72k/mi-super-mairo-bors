class_name InputBuffer
extends Node

var buffer: Array[String] = []
var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.get_child_count() == 1, "You need a 1 timer!")
	timer = self.get_child(0)
	timer.ignore_time_scale = true
	timer.timeout.connect(_input_timeout)


func add_input(input: String):
	print("añado un input al buffer")
	buffer.push_front(input)
	timer.start()
	


func get_input() -> String:
	if buffer.size() > 0:
		print("get_input")
		return buffer.back()
	else:
		return ""


func consume_input(input_exp: bool) -> bool:
	if input_exp:
		buffer.pop_back()
		
		if buffer.size() > 0:
			timer.start()
		
		return true
	return false


func _input_timeout():
	print("input muere por inanación")
	# Remove input for each timeout (even without input).
	buffer.pop_back()
	
	# Still have input? Restart timer again.
	if buffer.size() > 0:
		timer.start()


func size() -> int:
	return buffer.size()
