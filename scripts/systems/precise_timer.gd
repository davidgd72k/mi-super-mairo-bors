class_name PreciseTimer
extends Node

signal timeout

## Wait time for timer. Based in seconds (1.0 = 1 second, 0.5 = half second).
@export var wait_time: float = 1.0
@export var autostart: bool = false
@export var looped: bool = false

## Time remains in timer.
var time_left: float
var _running: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_left = wait_time
	
	if autostart:
		print("empiezo antes")
		start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _running:
		print("pasa tiempo")
		time_left -= delta
	
	if time_left <= 0.0:
		print("fin ciclo tempo, mando un aviso.")
		timeout.emit()
		reset_time()


func reset_time():
	if looped:
		print("reseteo y sigo")
		time_left = wait_time
	else:
		print("se acabo, estoy en 0")
		time_left = 0.0
	time_left = wait_time
	_running = true if looped else false
	


func start(time_sec: float = -1):
	print("arranca el tempo")
	_running = true
	
	wait_time = time_sec if time_sec > 0 else wait_time
	time_left = wait_time


func stop():
	print("Para el tempo.")
	time_left = 0
	_running = false
