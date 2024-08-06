extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")
@export var speed = 260
@export var damage = 100
@export var direction: Vector2 = Vector2.RIGHT

func _ready():
	pass 



func _process(delta):
	position += direction * speed * delta
	
	if position.x > get_viewport_rect().size.x or position.x < 0:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		var player_hp_tween = get_tree().create_tween()
		await player_hp_tween.tween_property(player,"hp",0,1.4).finished

