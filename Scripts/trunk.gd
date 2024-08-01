extends CharacterBody2D


@export var speed = 120
@export var direction: Vector2 = Vector2.RIGHT
@export var lifetime = 10.0

func _ready():
	$Timer.wait_time = lifetime
	$Timer.start()
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))


func _on_timer_timeout():
	queue_free()
