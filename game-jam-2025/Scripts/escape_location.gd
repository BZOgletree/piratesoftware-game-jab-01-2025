extends Area2D

@export var player: Node2D
@export var sprite: AnimatedSprite2D

func _physics_process(delta: float) -> void:
	print('No enterd')

func _on_area_entered(area: Area2D):
	print('Entered')
	if area != player:
		sprite.play('Closing')
		await sprite.animation_finished
		sprite.play('Opening')
		await sprite.animation_finished
