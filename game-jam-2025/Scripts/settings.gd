extends CanvasLayer

@export var scene_transition: CanvasLayer
@export var sound_effects := true
@export var music := true

func _ready():
	sound_effects = true
	Settings.sound_effects = true
	music = true
	Settings.music = true

func _on_button_pressed() -> void:
	Settings.sound_effects = !sound_effects 
	sound_effects = Settings.sound_effects
	$Button.text = 'Sound Effects: ' + ('On' if sound_effects else 'Off')
	pass # Replace with function body.

func _on_button_2_pressed() -> void:
	Settings.music = !music
	music = Settings.music
	$Button2.text = 'Music: ' + ('On' if music else 'Off')
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	self.visible = false
	pass # Replace with function body.
