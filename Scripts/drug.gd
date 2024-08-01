extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var car_1 = get_tree().get_first_node_in_group("Car")
@export var duration = 15.0


func _ready():
	pass
	

func _on_body_entered(body):
	if body is Player:
		player.speed = 180
		car_1.speed = 100.0
		print("enzooo")
		queue_free()

