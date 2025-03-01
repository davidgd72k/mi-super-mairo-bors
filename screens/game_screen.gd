extends Node2D

@onready var state_label: Label = $CanvasLayer/StateLabel
@onready var data_label: Label = $CanvasLayer/DataLabel
@onready var coin_label: Label = $CanvasLayer/CoinLabel
@onready var player: CharacterBody2D = $Player
@onready var current_level: Node2D = $CurrentLevel

var coins: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coin_label.text = "Coins: " + str(coins)
	# Pick a coin --> update coin text.
	if current_level.has_node("Coins"):
		for m in current_level.get_node("Coins").get_children():
			(m as Coin).pick_up.connect(_update_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	data_label.text = "GRAV_SPEED: " + str(player.velocity.y)
	state_label.text = "Current state: " + str(player.fsm.state.name)


func _physics_process(delta: float) -> void:
	if (player.position.y > 1300):
		player.global_position = $CurrentLevel/Respawn.global_position


func _update_text():
	coins += 1
	coin_label.text = "Coins: " + str(coins)
	AudioManager.play("res://assets/audio/sfx/coin.wav")
