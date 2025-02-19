class_name Player extends CharacterBody2D

@export_group("Jumping")
## Altura a la que llegará tu personaje.
@export var jump_height: float = 100.0
## Tiempo que tardará en alcanzar dicha altura.
@export var jump_time_to_peak: float = 1
## Tiempo que tardará en caer.
@export var jump_time_to_descent: float = 0.5

@export var peak_time: float = 0.5
@export_group("Horizontal movement")
## Velocidad horizontal.
@export var running_speed: float = 400.0
@export_group("Coyote Time")
@export var coyote_frames: int = 8
@export var corner_distance_correction = 64

# Time-based gravity vars.
var jump_velocity: float = 0
var jump_gravity: float = 0
var fall_gravity: float = 0

# Coyote time related variables.
var coyote := false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var fsm: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var input_buffer: InputBuffer = $InputBuffer

#region Godot Basics functions.
func _ready() -> void:
	$CoyoteTimer.wait_time = coyote_frames / 60.0
	redefine_jumping_vars()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("b_a"):
		input_buffer.add_input("b_a")


func _physics_process(delta: float) -> void:
	pass
#endregion

## Apply horizontal movement to player character.
func horizontal_moving(direction: float, speed: float) -> float:
	return direction * speed


#region Time-based jump logic.
## Apply jump impulse to player character.
func jump():
	velocity.y = jump_velocity


## Get gravity based on timing (both in jumping and falling).
func get_own_gravity() -> float:
	var own_gravity = jump_gravity if velocity.y < 0.0 else fall_gravity
	return own_gravity


## Redefine variables used for time-based gravity 
## (recommended call this for any change in him implied variables).
func redefine_jumping_vars():
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
#endregion

## Play squashing animation when player hit ground.
func play_squashing_animation():
	animation_tree.set("parameters/InGround/AddSquash/add_amount", 1.0)


## Reset coyote-time use.
func _on_coyote_timer_timeout() -> void:
	coyote = false
