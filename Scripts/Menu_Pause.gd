extends CanvasLayer

@onready var continue_button = $VBoxContainer/Continue

func _ready():
	visible = true


func _process(delta):
	pass


func _on_continue_pressed():
	get_tree().paused = false
	visible = false
	
func _on_restart_pressed():
	Global.game_over()
