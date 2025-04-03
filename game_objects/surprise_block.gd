class_name SurpriseBlock
extends StaticBody2D

var pushed: bool = false

@onready var coin_particle: GPUParticles2D = $CoinParticle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coin_particle.emitting = false
	coin_particle.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hit_zone_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("pushed")
	
	if not pushed:
		AudioManager.play("res://assets/audio/sfx/coin.wav")
		$Sprite2D.modulate = Color(0.577, 0.577, 0.577)
		pushed = not pushed
		coin_particle.emitting = true
	else:
		AudioManager.play("res://assets/audio/sfx/sfx_golpe_duro.ogg")
		
	
