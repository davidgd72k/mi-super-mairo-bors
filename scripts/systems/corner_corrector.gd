class_name CornerCorrector
extends Node2D

signal correction(side: Side)

enum Side {
	Left,
	Right,
}

@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	_detect_corner()


## Detecting corner when jump. Emit signal when one raycast is colliding.
func _detect_corner() -> void:
	var left_hit = ray_left.is_colliding()
	var right_hit = ray_right.is_colliding()
	
	if left_hit and not right_hit:
		correction.emit(Side.Left)
	elif right_hit and not left_hit:
		correction.emit(Side.Right)
