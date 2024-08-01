extends Node2D

@onready var point_light = $PointLight2D

func _ready():
	point_light.visible = true

func _process(delta):
	pass
