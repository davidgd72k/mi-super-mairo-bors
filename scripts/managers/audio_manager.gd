extends Node

var num_audio_players = 16 # ¿Cuantos AudioStreamPlayers se pueden usar como máximo?
var bus = "master" # Bus de audio a usar.

var available = [] # Lista de players disponibles.
var queue = [] # Cola de sonidos a reproducir.


func _ready():
	# Creamos un pool de nodos AudioStreamPlayer.
	for i in num_audio_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(on_stream_finished.bind(p))
		p.bus = bus


func _process(delta):
	# Reproduce los sonidos de la cola si hay players disponibles para ello.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()


func play(sound_path):
	# La ruta debe incluir el "res://" para ser valida.
	queue.append(sound_path)


func on_stream_finished(stream):
	# Cuando un stream termine de sonar su sonido; es liberado.
	available.append(stream)
