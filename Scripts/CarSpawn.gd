extends Node2D

@export var car_scenes: Array = [
	preload("res://Scenes/car_1.tscn"),
	preload("res://Scenes/car_2.tscn"),
	preload("res://Scenes/car_3.tscn")
]

@export var spawn_interval: float = 2.0
@export var spawn_area_left: Rect2 = Rect2(Vector2(-20,0), Vector2(94,60)) # Área da esquerda
@export var spawn_area_right: Rect2 = Rect2(Vector2(1100,0), Vector2(1,1)) # Área da direita

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
	else:
		spawn_position = Vector2(
			randf_range(spawn_area_right.position.x, spawn_area_right.position.x + spawn_area_right.size.x),
			randf_range(spawn_area_right.position.y, spawn_area_right.position.y + spawn_area_right.size.y),
		)
		car_instance.position = spawn_position
		car_instance.direction = Vector2.LEFT # Direção do movimento definida
		car_instance.get_node("sprite").flip_h = true
		var point_light = car_instance.get_node("PointLight2D")
		point_light.offset = Vector2(-700,0) #Luz vai acompanhar a inversão do sprite
		
	add_child(car_instance)



