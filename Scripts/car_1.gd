extends CharacterBody2D
class_name Car

@export var speed = 100
@export var damage = 100
@export var direction: Vector2 = Vector2.RIGHT
@onready var point_light_car1 = $PointLight2D


func _ready():
	point_light_car1.visible = true 



func _process(delta):
	position += direction * speed * delta
	
	#Remove o carro se ele sair da tela
	if position.x > get_viewport_rect().size.x or position.x < 0:
		queue_free()


