extends Node2D

@export var ambient_interval: float = 10.0 # Intervalo que um novo ambiente é introduzido.
@export var ambient_duration: float = 5.0 # Tempo que o ambiente introduzido ficará na tela
@export var ambient_scenes: Array = [
	preload("res://Scenes/rain.tscn"),
	preload("res://Scenes/snow.tscn")
]

@onready var day_timer = $day_timer
@onready var scene_timer = $scene_timer
@onready var fade_timer = $fade_timer
@onready var time_label = $Label
var scene_instantiate = null
@onready var poste = get_tree().get_nodes_in_group("Poste")


func _ready():
# Configurando o timer do dia 
	day_timer.wait_time = ambient_interval
	day_timer.one_shot = false
	day_timer.timeout.connect(_on_day_timer_timeout)
	day_timer.start()
	add_child(day_timer)
	
# Configurações do timer da cena
	scene_timer.wait_time = ambient_duration
	scene_timer.one_shot = false
	scene_timer.timeout.connect(_on_scene_timer_timeout)
	scene_timer.start()
	add_child(scene_timer)
	
# Configurações do fade da cena instanciada
	fade_timer.wait_time = 0.1 # Atualiza a opacidade a cada 1 segundo
	fade_timer.one_shot = false
	fade_timer.timeout.connect(_on_fade_timer_timeout)
	fade_timer.start()
	add_child(fade_timer)
	
# Configuração Label do tempo
	time_label.text = "00:00"
	time_label.position = Vector2(10, 10)
	add_child(time_label)

	set_process(true)

func _process(delta):
# Atualizando o tempo no label 
	var seconds_passed = int(day_timer.time_left)
	var minutes = seconds_passed / 60
	var seconds = seconds_passed % 60
	time_label.text = "New ambient in: " + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func _on_day_timer_timeout():
# Instanciando cena aleatória
	var random_scene = ambient_scenes[randi() % ambient_scenes.size()]
	scene_instantiate = random_scene.instantiate()
	scene_instantiate.modulate.a = 0 # Opacidade começa em zero

# Adicionar a cena na tela 
	add_child(scene_instantiate)

# Ativando a luz do poste quando uma cena surge
	_post_light(true)
# Iniciar o timer para introduzir gradualmente a cena na tela(uso da sua opacidade)
	fade_timer.start()

# Iniciando o timer para remover a cena depois do tempo que foi definido
	scene_timer.start()

# Reiniciar o timer do dia
	day_timer.start()

func _on_scene_timer_timeout():
# Iniciar o time de fade para diminuir gradualmente sua opacidade
	fade_timer.start()

# Remover a cena após o tempo definido
	for child in get_children():
		if child is Node2D and child != time_label and child != day_timer and child != scene_timer:
			child.queue_free()


func _on_fade_timer_timeout():
	if scene_instantiate != null:
		if scene_instantiate.modulate.a < 1 and scene_timer.time_left > ambient_duration - 2.5:
			scene_instantiate.modulate.a += 0.04 #Aumenta gradualmente a opacidade
			if scene_instantiate.modulate.a > 1:
				scene_instantiate.modulate.a = 1
			elif scene_timer.time_left <= 2.5:
				scene_instantiate.modulate.a -= 0.04 #Diminui gradualmente a opacidade
				if scene_instantiate.modulate.a < 0:
					scene_instantiate.modulate.a = 0
					scene_instantiate.queue_free()
					scene_instantiate = null
					fade_timer.stop()
					_post_light(false)

func _post_light(state: bool):
	for post in poste:
		if post.has_node("PointLight2D"):
			post.get_node("PointLight2D").visible = state
