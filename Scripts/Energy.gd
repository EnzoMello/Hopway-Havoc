extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var count = get_tree().get_first_node_in_group("Contador")
@onready var cars = get_tree().get_first_node_in_group("Car")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		count.score += 3
		player.speed = 300
		print("bola")
		queue_free()
