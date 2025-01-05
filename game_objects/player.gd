class_name Player extends CharacterBody2D

@export_group("Jumping")
## Altura a la que llegará tu personaje.
@export var jump_height: float = 100.0
## Tiempo que tardará en alcanzar dicha altura.
@export var jump_time_to_peak: float = 1
## Tiempo que tardará en caer.
@export var jump_time_to_descent: float = 0.5
@export_group("Horizontal movement")
## Velocidad horizontal.
@export var horizontal_speed: float = 400.0

# Player nodes.
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

# Time-based gravity vars.
@onready var jump_velocity: float = 0
@onready var jump_gravity: float = 0
@onready var fall_gravity: float = 0

func _ready() -> void:
	animation_player.play("walk")
	redefine_jumping_vars()
	

func _physics_process(delta: float) -> void:
	# Apply time-based gravity.
	if not is_on_floor():
		velocity.y += get_own_gravity() * delta

	# Handle jumping from the ground.
	if Input.is_action_just_pressed("b_a") and is_on_floor():
		jump()

	# Horizontal movement logic.
	var direction := Input.get_axis("d_left", "d_right")
	if direction:
		var my_speed := horizontal_speed
		
		if Input.is_action_pressed("b_b") and is_on_floor():
			my_speed *= 2
		
		velocity.x = horizontal_moving(direction, my_speed)
		sprite_2d.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, horizontal_speed)

	move_and_slide()

## Apply horizontal movement to player character.
func horizontal_moving(direction: float, speed: float) -> float:
	return direction * speed


func simulate_fall(fake_gravity: float):
	velocity.y += fake_gravity


func starting_fall():
	simulate_fall(fall_gravity*2)
	await self.is_on_floor()
	
#region Time-based jump logic.
## Apply jump impulse to player character.
func jump():
	velocity.y = jump_velocity

## Get gravity based on timing (both in jumping and falling.
func get_own_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

## Redefine variables used for time-based gravity 
## (recommended call this for any change in him implied variables).
func redefine_jumping_vars():
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
#endregion
