extends CanvasLayer

@export var stopwatch_label: Label
@export var health_label: Label
@export var target_label: Label
@export var warning_label: Label
@export var max_health: int
@export var song : AudioStreamPlayer

var stopwatch: Stopwatch
var time = 0.0
var health = max_health
var previous_sec = 0
var number_of_targets_remaining: int
var stopped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	update_number_of_targets_remaining()
	health = max_health
	if Settings.music:
		song.playing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_stopwatch_label()
	update_number_of_targets_remaining()
	if stopped:
		pass
	else:
		time += delta
	var sec = fmod(time, 60)
	if int(previous_sec) != int(sec):
		update_health_label(sec)
	pass

func update_stopwatch_label():
	stopwatch_label.text = stopwatch.time_to_string()
	
func update_health_label(sec):
	previous_sec = sec
	if health > max_health:
		health = max_health
	health -= 1
	health_label.text = 'Health: ' + str(health)

func update_number_of_targets_remaining():
	number_of_targets_remaining = get_tree().get_node_count_in_group("targets")
	target_label.text = "Remaining: " + str(get_tree().get_node_count_in_group("targets"))
