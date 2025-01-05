class_name TitleScreen extends Node2D

# TODO: programar lógica básica de esta pantalla (similar al del Super Mario Bros).
# TODO: que la opción seleccionada se "ilumine" en rojo (aka que cambie de color).
# TODO: poder seleccionar las opciones.
# TODO: opción Jugar: inicia el juego.
# TODO: opción Ayuda: muestra la ayuda del juego.
# TODO: opción Sobre...: muestra los créditos del juego.
# TODO: opción Salir: cierra el juego.

var selected_option_id: int = 1
var all_options_count: int

func _ready() -> void:
	all_options_count = get_node("CanvasLayer/MenuOptions").get_child_count()
	recolocate_cursor(selected_option_id)
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("d_up"):
		selected_option_id = clamp((selected_option_id - 1), 1, all_options_count)
		recolocate_cursor(selected_option_id)
	elif Input.is_action_just_pressed("d_down"):
		selected_option_id = clamp((selected_option_id + 1), 1, all_options_count)
		recolocate_cursor(selected_option_id)
	
	if Input.is_action_just_pressed("b_a"):
		do_option_action(selected_option_id)

func do_option_action(option: int):
	match option:
		1:
			print("TO DE MARIO")
			get_tree().change_scene_to_file("res://screens/game_screen.tscn")
		2:
			print("HELP!")
		3:
			print("Quiero agradecerle a Alva Majo y a Guinxu por su gran labor y...")
		4:
			print("Me void")
			get_tree().quit()
	pass

func recolocate_cursor(new_pos: int):
	var option_nodes := %MenuOptions.get_children()
	assert(option_nodes.size() > 0, "Debe haber al menos una opción")
	var label_mid_y_size: float = (option_nodes[0] as Label).size.y / 2
	# Los label se utilizan cómo puntos de referencia para el marcador.
	var options_names = (func(nodes: Array[Node]) -> Array[String]:
		var names: Array[String] = []
		for i in nodes:
			names.append(i.name)
		
		return names
		).call(option_nodes)
	
	%SelectArrow.global_position.y = \
		%MenuOptions.get_node(options_names[new_pos - 1]).global_position.y + label_mid_y_size
