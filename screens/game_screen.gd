extends Node2D

@onready var state_label: Label = $CanvasLayer/StateLabel
@onready var data_label: Label = $CanvasLayer/DataLabel
@onready var player: CharacterBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	data_label.text = "GRAV_SPEED: " + str(player.velocity.y)
	state_label.text = "Current state: " + str(player.fsm.state.name)


func _physics_process(delta: float) -> void:
	if (player.position.y > 1300):
		player.position = Vector2(10, 10)
