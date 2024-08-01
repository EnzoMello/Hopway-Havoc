extends Node2D

@export var animation_duration: float = 1.0
@export var target_position: Vector2 = Vector2(100, -200)

@onready var title_label = $TitleLabel

var animation_time = 0.0
var is_animating = false
var start_position = Vector2.ZERO

func _ready():
	start_position = title_label.rect_position

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		start_title_animation()

func _process(delta):
	if is_animating:
		animation_time += delta
		var t = animation_time / animation_duration
		if t > 1.0:
			t = 1.0
			is_animating = false
			# Transição para a cena do jogo ou outra lógica
			print("Animation finished. Start the game!")
			# get_tree().change_scene("res://Scenes/YourGameScene.tscn")
		
		# Interpolação linear da posição e opacidade
		title_label.rect_position = start_position.linear_interpolate(target_position, t)
		title_label.modulate.a = 1.0 - t

func start_title_animation():
	animation_time = 0.0
	is_animating = true
