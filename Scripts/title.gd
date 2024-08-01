extends Control

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var camera = get_tree().get_first_node_in_group("Camera")
@onready var Start = $start as Button
@onready var Exit = $exit as Button
@onready var cam = $Camera2D
func _ready():
	var tween = get_tree().create_tween()
	await tween.tween_property(cam,"zoom",Vector2(1,1),4)
	Start.button_down.connect(_on_start_pressed)
	Exit.button_down.connect(_on_exit_pressed)

func _process(delta):
	pass


func _on_start_pressed():
	var zoom_tween = get_tree().create_tween()
	var start_tween = get_tree().create_tween()
	var exit_tween = get_tree().create_tween()
	zoom_tween.tween_property(cam,"zoom",Vector2(1.7,1.7),1)
	await start_tween.tween_property($start,"modulate",Color(1,1,1,0),4)
	await exit_tween.tween_property($exit,"modulate",Color(1,1,1,0),4).finished
	$title.visible = false
	Start.visible = false
	Exit.visible = false

func _on_exit_pressed():
	get_tree().quit()
