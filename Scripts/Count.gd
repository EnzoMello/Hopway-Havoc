extends Node2D

@export var score_increment: float = 64.0
@onready var score_label = $Score
@onready var player = get_tree().get_first_node_in_group("Player")

var score = 0
var player_position = Vector2()

func _ready():
	score_label.text = str(score) # Inicia o score
	player_position = player.position # Salva a última posição do player
	
func _process(delta):
	var distance_moved = player.position.distance_to(player_position)
	if distance_moved >= score_increment:
		score += 1
		print("enzola")
		score_label.text = "Score: " + str(score)
		player_position = player.position
