class_name BasicCameraController extends Camera2D

@export var target: Node2D
@export var cursor_moving_mode: bool = false
@export var speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cursor_moving_mode:
		var direction := Input.get_vector("d_left","d_right","d_up", "d_down")
		self.global_position += direction * speed
		return 
		
	if target != null:
		self.global_position = target.global_position
