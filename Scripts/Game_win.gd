extends CanvasLayer

@onready var restart = $VBoxContainer/Restart
@onready var exit = $VBoxContainer/Exit

func _ready():
	pass 

func _process(delta):
	pass


func _on_restart_pressed():
	Global.transition_to_scene("game")


func _on_exit_pressed():
	get_tree().quit()
