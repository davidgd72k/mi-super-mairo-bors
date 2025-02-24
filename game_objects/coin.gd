class_name Coin
extends Area2D

signal pick_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	pick_up.emit()
	
	if not is_queued_for_deletion():
		queue_free()
