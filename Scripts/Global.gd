extends Node

var max_salas = 40
var min_salas = 20
var salas_p_criadas = 35

func game_over():
	print("Game Over! Reiniciando a cena...")
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()

