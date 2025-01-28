extends CanvasLayer


func scene_transition(target: String) -> void :
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")
