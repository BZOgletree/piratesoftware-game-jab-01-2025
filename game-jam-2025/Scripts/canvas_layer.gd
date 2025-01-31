extends CanvasLayer

@export var zombie_groan: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.sound_effects:
		zombie_groan.playing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Claw"):
		self.visible = false
