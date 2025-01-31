extends CanvasLayer

@export var sceneTransition: CanvasLayer
@export var settings: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	$AnimatedSprite2D.play("Title Crawl")
	await $AnimatedSprite2D.animation_finished
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$AnimatedSprite2D2.play('Idle')
	await $AnimatedSprite2D2.animation_finished
	sceneTransition.scene_transition('res://Scenes/Floor6 (First level)/floor_6_first_level.tscn')


func _on_button_2_pressed() -> void:
	settings.visible = true
	pass # Replace with function body.
