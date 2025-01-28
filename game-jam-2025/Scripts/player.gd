extends CharacterBody2D
const speed = 200

@export var hud: CanvasLayer
@export var sprite: AnimatedSprite2D
@export var bite: AnimatedSprite2D
@onready var area2D = $Area2D

var kill_state = false
var break_barrier = false
var collision
var infected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bite.visible = false
	infected = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_input()
	move_and_slide()
	check_for_kill()

func get_input(): 
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
	print(layer)
	print(area)
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

func _on_bite_animation_finished() -> void:
	bite.visible = false
