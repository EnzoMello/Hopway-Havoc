extends Area2D
@onready var timer = $Timer
@onready var player = get_tree().get_first_node_in_group("Player")

func _on_body_entered(body):
	if body is Player:
		player.hp = 0
		print("You died")
		timer.start()
	
#func _on_timer_timeout():
	#get_tree().reload_current_scene()
