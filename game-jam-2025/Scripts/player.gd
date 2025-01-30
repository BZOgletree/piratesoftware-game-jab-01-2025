extends CharacterBody2D
const speed = 200

@export var hud: CanvasLayer
@export var sprite: AnimatedSprite2D
@export var bite: AnimatedSprite2D
@export var stairs: Node2D
@export var scene_transition: CanvasLayer
@onready var area2D = $Area2D
@onready var nav_agent := $NavigationAgent2D
@export var finish_level_screen: CanvasLayer
@export var allowed_remaining: int

var kill_state = false
var break_barrier = false
var collision
var infected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bite.visible = false
	finish_level_screen.visible = false
	infected = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_input()
	move_and_slide()
	check_for_kill()
	check_for_exit()

func get_input(): 
	print(nav_agent.distance_to_target())
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	if input_direction != Vector2(0,0):
		sprite.animation = "Moving"
	else:
		sprite.animation = "Idle"
	if velocity.x > 0:
		sprite.rotation_degrees = 90
		bite.rotation_degrees = 90
	if velocity.y > 0:
		sprite.rotation_degrees = 180
		bite.rotation_degrees = 180
	if velocity.y < 0:
		sprite.rotation_degrees = 0
		bite.rotation_degrees = 0
	if velocity.x < 0:
		sprite.rotation_degrees = 270
		bite.rotation_degrees = 270

func _on_area_2d_area_entered(area: Area2D) -> void:
	var layer = area.get_collision_layer()
	if layer == 6:
		kill_state = true
	collision = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	kill_state = false

func check_for_kill():
	if Input.is_action_just_pressed("Bite") && kill_state:
		biting()
		collision.get_parent().queue_free()
		hud.health += 3
		infected += 1

func biting():
	bite.visible = true
	bite.animation = "Bite"
	bite.play()
	infected += 1

func _on_bite_animation_finished() -> void:
	bite.visible = false
	
func check_for_exit() -> void:
	nav_agent.target_position = stairs.global_position
	if nav_agent.distance_to_target() < 100:
		if hud.number_of_targets_remaining <= allowed_remaining:
			finish_level_screen.number_of_enemies_killed = infected
			hud.stopped = true
			finish_level_screen.final_time = str(hud.time)
			scene_transition.scene_transition('level_complete')
		else:
			hud.warning_label.visible = true
			hud.warning_label.text = 'I sense too many humans in the area...'
			await get_tree().create_timer(1.0).timeout
			hud.warning_label.visible = false
