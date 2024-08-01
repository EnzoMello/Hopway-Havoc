extends Camera2D

@export var camera_speed: float = 1.7 #Velocidade da câmera
@export var game_over_offset: float = 10.0 #útil mais tarde no código 
@onready var camera = $"."
@onready var player = $".."


var is_game_over = false

func _process(delta):
	if is_game_over:
		return
	
	camera.position.y -= camera_speed * delta  # Movendo a câmera
	if player.position.y > camera.position.y + get_viewport().size.y / 3: # Verificando o game over
		Global.game_over()
	
