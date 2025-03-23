class_name Goomba
extends CharacterBody2D

#region TODO list
# TODO: solo se puede llamar a la función stomp cuando la hitbox de player sea la de aplastar.
#endregion
@export var life: int = 1

# regular variables.

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity.x = (1 * 200)
	velocity.y += get_gravity().y * delta
	move_and_slide()


func stomp() -> void:
	print("me chafaron")
	sprite_2d.scale.y = 0.1
	set_physics_process(false)
	await get_tree().create_timer(1.5).timeout
	queue_free()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Player:
		print("le dieron al player")
		body.do_damage(1)
