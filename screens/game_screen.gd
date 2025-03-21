class_name GameScreen
extends Node2D

var coins: int = 0

@onready var state_label: Label = $DebUI/StateLabel
@onready var data_label: Label = $DebUI/DataLabel
@onready var coin_label: Label = $DebUI/CoinLabel
@onready var player: CharacterBody2D = $Player
@onready var current_level: Node2D = $CurrentLevel
@onready var camera_2d: BasicCameraController = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coin_label.text = "Coins: " + str(coins)
	# Pick a coin --> update coin text.
	if current_level.has_node("Coins"):
		for m in current_level.get_node("Coins").get_children():
			(m as Coin).pick_up.connect(_update_coin_text)
	
	# Connect player visible-notifier.
	(player.get_node("VisibleOnScreenNotifier2D") as VisibleOnScreenNotifier2D) \
			.screen_exited.connect(_on_player_exited_from_screen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	data_label.text = "GRAV_SPEED: " + str(player.velocity.y)
	state_label.text = "Current state: " + str(player.fsm.state.name)


func _physics_process(delta: float) -> void:
	#if (player.position.y > 1300):
		#player.global_position = $CurrentLevel/Respawn.global_position
		pass


func _update_coin_text():
	coins += 1
	coin_label.text = "Coins: " + str(coins)
	AudioManager.play("res://assets/audio/sfx/coin.wav")


func _on_player_exited_from_screen() -> void:
	player.global_position = $CurrentLevel/Respawn.global_position
	
