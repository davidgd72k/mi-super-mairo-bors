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
@export var horizontal_speed: float = 400.0

# Time-based gravity vars.
var jump_velocity: float = 0
var jump_gravity: float = 0
var fall_gravity: float = 0

var peak_timer: Timer

var in_peak: bool = false
var you_must_falling: bool = false
var peak_height: float = 0
var jumping: bool = false

# Player nodes.
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var fsm: StateMachine = $StateMachine


func _ready() -> void:
	redefine_jumping_vars()


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass





func decide_animation():
	if jumping:
		animation_player.play("jump")
	else:
		if velocity.length() > 0:
			animation_player.play("walk")
		else:
			animation_player.play("idle")

## Apply horizontal movement to player character.
func horizontal_moving(direction: float, speed: float) -> float:
	return direction * speed

func is_peak_height_reach() -> bool:
	return self.global_position.y <= peak_height - 50


#region Time-based jump logic.
## Apply jump impulse to player character.
func jump():
	peak_height = get_peak_height()
	velocity.y = jump_velocity

## Get gravity based on timing (both in jumping and falling).
func get_own_gravity() -> float:
	var own_gravity = jump_gravity if velocity.y < 0.0 else fall_gravity
	return own_gravity

func get_peak_height() -> float:
	var old_height: float = self.global_position.y
	# HACK: cambia ese número mágico por una variable export.
	return old_height - jump_height

## Redefine variables used for time-based gravity 
## (recommended call this for any change in him implied variables).
func redefine_jumping_vars():
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
#endregion
