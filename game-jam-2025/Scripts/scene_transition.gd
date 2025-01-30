extends CanvasLayer

@export var finished_level: CanvasLayer

func scene_transition(target: String) -> void :
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	if target == 'level_complete':
		finished_level.update_information()
		finished_level.visible = true
	else:
		get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
