extends Node2D
class_name CornerCorrector

signal correction(side: Side)

enum Side {
	Left,
	Right,
}

@export var correction_time: float = 1.0

var check_timer: Timer
var checking_corners: bool = false

@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight

func _ready() -> void:
	check_timer = Timer.new()
	check_timer.wait_time = correction_time
	check_timer.one_shot = true
	check_timer.timeout.connect(_on_check_timer_timeout)
	add_child(check_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Checking every frame if player hit a corner.
	if checking_corners:
		var detect := detect_corner()
		print("Corner detected?: " + ("Yes!" if detect else "Nop"))
		if detect:
			checking_corners = false
		


func _physics_process(delta: float) -> void:
	pass


func activate() -> void:
	if not checking_corners:
		print("inicia timer")
		checking_corners = true
		check_timer.start()


## Detecting corner when jump. Emit signal when one raycast is colliding.
func detect_corner() -> bool:
	var detected: bool = true
	var left_hit = ray_left.is_colliding()
	var right_hit = ray_right.is_colliding()
	
	if left_hit and not right_hit:
		correction.emit(Side.Left)
	elif right_hit and not left_hit:
		correction.emit(Side.Right)
	else:
		detected = false
	
	return detected


func _on_check_timer_timeout():
	checking_corners = false
