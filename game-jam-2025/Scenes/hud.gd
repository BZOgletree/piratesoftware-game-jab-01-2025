extends CanvasLayer

@export var stopwatch_label: Label
@export var health_label: Label

var stopwatch: Stopwatch
var time = 0.0
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_stopwatch_label()
	time += delta
	var sec = fmod(time, 60)
	update_health_label(sec)
	pass

func update_stopwatch_label():
	stopwatch_label.text = stopwatch.time_to_string()
	
func update_health_label(sec):
	if health > 100:
		health_label.text = 'Health: ' + str(100 - int(sec))
	else:
		health_label.text = 'Health: ' + str(health - int(sec))
