class_name Goomba
extends CharacterBody2D

#region TODO list

#endregion

@export var life: int = 1

# regular variables.

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	gpu_particles_2d.one_shot = true
	gpu_particles_2d.emitting = false


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	# Moving to left.
	velocity.x = (1 * 200)
	velocity.y += get_gravity().y * delta
	move_and_slide()


func stomp() -> void:
	print("me chafaron")
	
	# For looking stomped.
	sprite_2d.scale.y = 0.1
	
	# Stopping moving.
	set_physics_process(false)
	
	# Avoid player "levitation" over body.
	(get_node("CollisionBox") as CollisionShape2D).queue_free()
	
	# By default is in one-shot mode.
	gpu_particles_2d.emitting = true
	
	# Simulating disappear effect like in Super Mario Bros.
	await get_tree().create_timer(1.5).timeout
	queue_free()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Player:
		print("le dieron al player")
		body.do_damage(1)


func desactive_hurt():
	$HurtBox.monitoring = false
