extends Node

func _ready():
	await get_tree().create_timer(0.5).timeout
	Gerar_salas()
	pass 

func Gerar_salas():
	randomize()
	var id = randi_range(1,5)
	
	if Global.salas_p_criadas > 1:
		var s = load("res://Scenes/sala_" + str(id) + ".tscn" ).instantiate()
		s.position = $saida.position
		add_child(s)
		Global.salas_p_criadas += -1

