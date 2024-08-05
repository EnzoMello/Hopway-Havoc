extends Node2D

@export var car_scenes: Array = [
	preload("res://Scenes/car_1.tscn")
	
]

@export var spawn_interval: float = 3.8
@export var spawn_area_left: Rect2 = Rect2(Vector2(-20,-10), Vector2(94,10)) # Área da esquerda

@onready var spawn_timer = $spawn_timer

func _ready():
		randomize() 
		spawn_timer.wait_time = spawn_interval
		spawn_timer.one_shot = false
		spawn_timer.timeout.connect(spawn_car)
		spawn_timer.start()
	
func _on_spawn_timer_timeout():
	spawn_car()

func spawn_car():
	var random_car_scene = car_scenes[randi() % car_scenes.size()]
	var car_instance = random_car_scene.instantiate()
	
	# Determinar se o carro surge na esquerda ou na direita
	var spawn_from_left = randi() % 2 == 0
	var spawn_position = Vector2()
	
	if spawn_from_left:
		spawn_position = Vector2(
			randf_range(spawn_area_left.position.x, spawn_area_left.position.x + spawn_area_left.size.x),
			randf_range(spawn_area_left.position.y, spawn_area_left.position.y + spawn_area_left.size.y),
		)
		car_instance.position = spawn_position
		car_instance.direction = Vector2.RIGHT # Direção do movimento definida
	
		
	add_child(car_instance)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
