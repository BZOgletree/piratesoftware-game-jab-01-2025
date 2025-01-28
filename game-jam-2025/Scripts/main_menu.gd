extends CanvasLayer

@export var sceneTransition: CanvasLayer

func _on_button_pressed():
	sceneTransition.scene_transition('res://Scenes/Floor6 (First level)/floor_6_first_level.tscn')
