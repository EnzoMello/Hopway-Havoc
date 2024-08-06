extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")


func _on_area_2d_body_entered(body):
	if body is Player:
		Global.transition_to_scene("2")
		Global.count_menu = 1
		
			

