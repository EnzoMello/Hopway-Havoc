extends CharacterBody2D

@export var speed = 280
@export var direction: Vector2 = Vector2.RIGHT

func _ready():
	pass 



func _process(delta):
	position += direction * speed * delta
	
	#Remove o tronco se ele sair da tela
	if position.x > get_viewport_rect().size.x or position.x < 0:
		queue_free()
