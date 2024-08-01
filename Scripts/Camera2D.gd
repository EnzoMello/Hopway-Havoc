extends Camera2D

var _intensity = 10
var _duration = 10
var _start_time = 0
var _rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	set_process(true)

func _process(delta):
	var decresser = (_duration - (Time.get_ticks_msec() - _start_time)) / _duration
	
	var ran_x = _rng.randf_range(-1,13) * _intensity * decresser
	var ran_y = _rng.randf_range(-1,13) * _intensity * decresser
	
	offset = Vector2(ran_x,ran_y)
	
	if decresser < 0:
		offset = Vector2.ZERO
		set_process(false)
		
func shakeCamera(intensity = 1.0, duration = 1.0):
	_intensity = float(intensity)
	_duration = float(duration * 1000)
	_start_time = Time.get_ticks_msec()
	
	set_process(true)

	
