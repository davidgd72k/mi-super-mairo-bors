class_name Goomba
extends CharacterBody2D

@export var life: int = 1

# regular variables.

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity.x = delta * 100
	move_and_slide()


func stomp() -> void:
	print("me chafaron")
	sprite_2d.scale.x = 0.1


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Player:
		print("le dieron al player")
		body.do_damage(1)
