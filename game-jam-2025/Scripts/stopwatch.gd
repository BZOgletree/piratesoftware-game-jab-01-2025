extends Node
class_name Stopwatch

var time = 0.0
var stopped = false
var level_complete_time

func _process(delta: float) -> void:
	if stopped:
		pass
	time += delta

func reset():
	time = 0.0

func time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60
	var formatted_string = "%02d : %02d : %02d"
	var actual_string = formatted_string % [min, sec, msec]
	return actual_string
