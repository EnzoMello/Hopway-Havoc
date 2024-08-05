extends Node

@onready var player = get_tree().get_first_node_in_group("Player")
var current_scene = null

func _ready():
	await get_tree().create_timer(15).timeout
	Gerar_salas()
	pass 

func Gerar_salas():
	randomize()
	var id = randi_range(1,5)
	
	if Global.salas_p_criadas > 1:
		current_scene = load("res://Scenes/sala_" + str(id) + ".tscn") as PackedScene
		var scene_instance = current_scene.instantiate()
		print("Rayysa")
		current_scene = scene_instance
		add_child(scene_instance)
		

func _on_area_2d_body_entered(body):
	if body is Player:
		Global.transition_to_scene(str(current_scene))
	print("Calderano")
