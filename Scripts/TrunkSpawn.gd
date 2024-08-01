extends Node2D

@export var bridge_scenes: Array = [
	preload("res://Scenes/trunk.tscn"),
	preload("res://Scenes/car_debug.tscn")
]

@export var spawn_interval: float = 4.0
@export var spawn_area: Rect2 = Rect2(Vector2(65,32), Vector2(170,10)) # Área da esquerda

@onready var spawn_timer = $spawn_timer

func _ready():
		randomize() 
		spawn_timer.wait_time = spawn_interval
		spawn_timer.one_shot = false
		spawn_timer.timeout.connect(spawn_bridge)
		spawn_timer.start()
	
func _on_spawn_timer_timeout():
	spawn_bridge()

func spawn_bridge():
	var random_bridge_scene = bridge_scenes[randi() % bridge_scenes.size()]
	var bridge_instance = random_bridge_scene.instantiate()
	
	var spawn_position = Vector2(
			randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
			randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y),
		)
	bridge_instance.position = spawn_position

	add_child(bridge_instance)



