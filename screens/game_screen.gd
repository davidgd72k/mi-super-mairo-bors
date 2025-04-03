class_name GameScreen
extends Node2D

var coins: int = 0

@onready var deb_labels: Dictionary = {
		"state":  $DebUI/StateLabel,
		"coin": $DebUI/CoinLabel,
		"data": $DebUI/DataLabel,
		"player_life": $DebUI/LifeLabel
}
@onready var player: CharacterBody2D = $Player
@onready var current_level: Node2D = $CurrentLevel
@onready var camera_2d: BasicCameraController = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deb_labels["coin"].text = "Coins: " + str(coins)
	# Pick a coin --> update coin text.
	if current_level.has_node("Coins"):
		for m in current_level.get_node("Coins").get_children():
			(m as Coin).pick_up.connect(_update_coin_text)
	
	# Connect player visible-notifier.
	(player.get_node("VisibleOnScreenNotifier2D") as VisibleOnScreenNotifier2D) \
			.screen_exited.connect(_on_player_exited_from_screen)
	(player as Player).damaged.connect(_update_life_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	deb_labels["data"].text = "GRAV_SPEED: " + str(player.velocity.y)
	deb_labels["state"].text = "Current state: " + str(player.fsm.state.name)


func _physics_process(delta: float) -> void:
		pass


func _update_coin_text():
	coins += 1
	deb_labels["coin"].text = "Coins: " + str(coins)
	AudioManager.play("res://assets/audio/sfx/coin.wav")


func _update_life_text():
	deb_labels["player_life"].text = "LIFE: "+ str((player as Player).life)

func _on_player_exited_from_screen() -> void:
	var screen_height = ProjectSettings.get("display/window/size/viewport_height")
	
	if player.global_position.y > screen_height:
		player.global_position = $CurrentLevel/Respawn.global_position
	
