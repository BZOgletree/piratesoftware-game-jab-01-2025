extends CanvasLayer

@export var scene_transition: CanvasLayer
@export var current_level: int
@export var next_level_button: Button
@export var target_time: String
var current_level_path
var next_level
var passed = numberOfEnemies/player.numberOfKilledEnemies > 0.65

@export var player: CharacterBody2D
@export var numberOfEnemies: int

func _ready() -> void:
	if !passed:
		next_level_button.disabled = true
		self.Label.text = 'Level Failed!'
	else:
		self.Label.text = 'Level Complete!'
		self.Label2.text = player.finished_time
		self.Label3.text = 'Rank: A'

func _on_button_pressed() -> void:
	find_next_level()
	scene_transition.scene_transition(current_level_path)
	pass # Replace with function body.

func find_next_level():
	if passed:
		if current_level == 1:
			current_level_path = 'res://Scenes/Floor6 (First level)/floor_6_first_level.tscn'
			next_level = 'res://Scenes/Floor5 (Second Level)/floor_5_level_2.tscn'
		elif current_level == 2:
			current_level_path = 'res://Scenes/Floor5 (Second Level)/floor_5_level_2.tscn'
			next_level = 'res://Scenes/Floor4 (Third Level)/floor_4_level_3.tscn'
		elif current_level == 3:
			current_level_path = 'res://Scenes/Floor4 (Third Level)/floor_4_level_3.tscn'
			next_level = 'res://Scenes/Floor3 (Fourth Level)/floor_3_level_four.tscn'
		elif current_level == 4:
			current_level_path = 'res://Scenes/Floor3 (Fourth Level)/floor_3_level_four.tscn'
			next_level = 'res://Scenes/Floor2 (Penultimate Level)/floor_2_level_5.tscn'
		elif current_level == 5:
			current_level_path = 'res://Scenes/Floor2 (Penultimate Level)/floor_2_level_5.tscn'
			next_level = 'res://Scenes/Floor1 (Final Level)/floor1.tscn'
		else:
			current_level_path = 'res://Scenes/Floor1 (Final Level)/floor1.tscn'
			next_level = 'res://Scenes/thanks_for_playing.tscn'
	else:
		pass


func _on_button_2_pressed() -> void:
	find_next_level()
	scene_transition.scene_transition(next_level)
	pass # Replace with function body.
