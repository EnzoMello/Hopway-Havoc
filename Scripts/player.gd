extends CharacterBody2D
class_name Player

@export var speed = 100
@export var hp = 100
@onready var distance_walk = 32
@onready var player_sprite = $Player_sprite
var target = Vector2()
@onready var player = $"."
@onready var Start = $Title/Start as Button
@onready var Exit = $Title/Exit as Button
@onready var Pause = $Title/Pause as Button
@onready var pause_scene = preload("res://Scenes/menu_pause.tscn") as PackedScene
@onready var transition = preload("res://Scenes/TransitionNode.tscn") as PackedScene
@onready var Clique = $Title/Clique
@onready var cam = $Camera2D
@onready var ambients = $Camera2D/Time
@onready var count = $Camera2D/Count
@onready var title = $Title

func _ready():
	
	if Global.count_menu == 1 or Global.count_menu == 2 or Global.count_menu == 3:
		title.queue_free()
	if Start.visible == false:
		speed = 100
		cam.zoom = Vector2(1.7,1.7)
	var tween = get_tree().create_tween()
	var ambients_tween_visibility = get_tree().create_tween()
	var count_tween = get_tree().create_tween()
	var clique_tween_zero = get_tree().create_tween()
	await tween.tween_property(cam,"zoom",Vector2(1.4,1.4),4)
	await ambients_tween_visibility.tween_property(ambients,"modulate",Color(1,1,1,0),0.1)
	await count_tween.tween_property(count,"modulate",Color(1,1,1,0),0.1)
	await clique_tween_zero.tween_property(Clique,"modulate",Color(1,1,1,0),0.1)
	Start.button_down.connect(_on_start_pressed)
	Exit.button_down.connect(_on_exit_pressed)
	target = position
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_position = get_global_mouse_position()
			var direction = position.direction_to(mouse_position)
			var new_target = position + direction * distance_walk * 2 # Quero que ele dê só dois passos
			if position.distance_to(mouse_position) > distance_walk * 2:
				target = new_target
			else:
				target = mouse_position


func _physics_process(delta):
	if cam.zoom == Vector2(1,1) and get_parent().name == "World":
		$Title/Start.set_mouse_filter(Control.MOUSE_FILTER_STOP)
		$Title/Exit.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	
	var direction = position.direction_to(target)
	velocity = direction * speed
	# look_at(target)
	if position.distance_to(target) > 10:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				player_sprite.flip_h = false
				player_sprite.play("walk")
			else:
				player_sprite.flip_h = true
				player_sprite.play("walk")
		else:
			if direction.y > 0:
				player_sprite.play("running_down")
			else:
				player_sprite.play("running_up")
		velocity = direction * speed
		move_and_slide()
		position += velocity * delta
	else:
		player_sprite.play("idle")
	
	if hp < 100:
		cam.shakeCamera()
		Global.count_score = 0
	if hp == 0:
		Global.game_over()

func _on_start_pressed():
	Songs.playSFX(preload("res://Assets/Coin (Sound FX).mp3"))
	speed = 0
	$Title/Start.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$Title/Exit.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	var zoom_tween = get_tree().create_tween()
	var start_tween = get_tree().create_tween()
	var exit_tween = get_tree().create_tween()
	var clique_tween = get_tree().create_tween()
	var ambients_tween = get_tree().create_tween()
	var countt_tween = get_tree().create_tween()
	var speed_tween = get_tree().create_tween()
	zoom_tween.tween_property(cam,"zoom",Vector2(1.5,1.5),3)
	cam.zoom = Vector2(1.5,1.5)
	await ambients_tween.tween_property(ambients,"scale",Vector2(1,1),2)
	await ambients_tween.tween_property(ambients,"modulate",Color(1,1,1,1),2)
	await countt_tween.tween_property(count,"modulate",Color(1,1,1,1),4)
	await start_tween.tween_property($Title/Start,"modulate",Color(1,1,1,0),2)
	await clique_tween.tween_property(Clique,"modulate",Color(1,1,1,1),1).set_delay(1)
	await clique_tween.tween_property(Clique,"modulate",Color(1,1,1,0),4).set_delay(4)
	await speed_tween.tween_property(player,"speed",100,3).set_delay(3)
	await exit_tween.tween_property($Title/Exit,"modulate",Color(1,1,1,0),2).finished
	$Title/title.visible = false
	Start.visible = false
	Exit.visible = false
	Start.queue_free()
	Exit.queue_free()
	title.queue_free()

func _on_exit_pressed():
	get_tree().quit()


	
	
