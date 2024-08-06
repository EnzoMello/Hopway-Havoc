extends Area2D
@onready var timer = $Timer
@onready var player = get_tree().get_first_node_in_group("Player")

func _on_body_entered(body):
	if body is Player:
		var player_hp_tween = get_tree().create_tween()
		await player_hp_tween.tween_property(player,"hp",0,1.4).finished
		timer.start()
	
#func _on_timer_timeout():
	#get_tree().reload_current_scene()
