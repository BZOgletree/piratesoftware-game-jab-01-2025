extends CanvasLayer

@export var scene_transition: CanvasLayer

func _on_button_pressed() -> void:
	scene_transition.scene_transition('res://Scenes/Floor6 (First level)/floor_6_first_level.tscn')
