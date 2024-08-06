extends Node

@onready var transition_scene = preload("res://Scenes/fade_in_transition.tscn") as PackedScene
var max_salas = 40
var min_salas = 5
var salas_p_criadas = 38
var current_sala = null
var previous_sala = null
var count_menu = 0
var count_score = 0

var main_scenes := {
	"game" : preload("res://Scenes/world.tscn"),
	"1" : preload("res://Scenes/sala_1.tscn"),
	"2" : preload("res://Scenes/sala_2.tscn"),
	"3" : preload("res://Scenes/sala_3.tscn"),
	"4" : preload("res://Scenes/sala_4.tscn")
	}

# Função que transiciona as cenas
func transition_to_scene(destiny_scene: String) -> void:
	var trans = transition_scene.instantiate()
	trans.destiny_scene = destiny_scene
	add_child(trans)

func game_over():
	print("Game Over! Reiniciando a cena...")
	var current_scene = get_tree().current_scene
	print("Hugo")
	get_tree().reload_current_scene()

	
