extends CanvasLayer

@export var scene_transition: CanvasLayer
@export var current_level: int
@export var next_level_button: Button
@export var target_time: String
@export var level_complete: Label
@export var time: Label
@export var rank: Label

var current_level_path
var next_level

@export var player: CharacterBody2D
@export var hud: CanvasLayer
@export var numberOfEnemies: int
@export var stopwatch: Stopwatch

var number_of_enemies_killed = 0
var passed
var final_time
var died = false

func _on_button_pressed() -> void:
	find_next_level()
	print(current_level_path)
	scene_transition.scene_transition(current_level_path)
	pass # Replace with function body.

func find_next_level():
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

func _on_button_2_pressed() -> void:
	find_next_level()
	scene_transition.scene_transition(next_level)
	pass # Replace with function body.

func update_information() -> void:
	number_of_enemies_killed = player.infected
	passed = float(number_of_enemies_killed) / float(numberOfEnemies) >= 0.60
	var msec = fmod(float(final_time), 1) * 1000
	var sec = fmod(float(final_time), 60)
	var min = float(final_time) / 60
	var formatted_string = "%02d : %02d : %02d"
	var actual_string = formatted_string % [min, sec, msec]
	if !passed || died:
		next_level_button.disabled = true
		level_complete.text = 'Level Failed!'
		time.text = 'Time: ' + actual_string
		rank.text = 'Rank: F'
		player.queue_free()
	else:
		level_complete.text = 'Level Complete!'
		time.text = 'Time: ' + actual_string
		rank.text = 'Rank: A'
		player.queue_free()
