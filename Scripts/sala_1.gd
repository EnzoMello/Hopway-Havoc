extends Node2D

@onready var cars = get_tree().get_first_node_in_group("Car")
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	pass

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body is Player:
		Global.transition_to_scene("win")
		Global.count_menu == 2
