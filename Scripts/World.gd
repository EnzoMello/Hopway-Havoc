extends Node2D

func _ready():
	Global.salas_p_criadas = randi_range(Global.min_salas, Global.max_salas)
	Gerar_salas()

func Gerar_salas():
	randomize()
	var id = randi_range(1,1)
	
	if Global.salas_p_criadas > 1:
		var s = load("res://Scenes/sala_" + str(id) + ".tscn" ).instantiate()
		s.position = $saida.position
		add_child(s)
		Global.salas_p_criadas += -1
