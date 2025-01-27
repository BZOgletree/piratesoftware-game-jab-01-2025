extends CharacterBody2D
const speed = 200

@export var hud: CanvasLayer
@onready var area2D = $Area2D

var kill_state = false
var break_barrier = false
var collision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_input()
	move_and_slide()
	check_for_kill()
	check_for_breaking_barrier()

func get_input(): 
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	var layer = area.get_collision_layer()
	if layer == 6:
		kill_state = true
		print("Can kill")
	if layer == 7:
		break_barrier = true
		print('Can break')
	collision = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	kill_state = false
	break_barrier = false

func check_for_kill():
	if Input.is_action_just_pressed("Bite") && kill_state:
		collision.get_parent().queue_free()
		hud.health += 10

func check_for_breaking_barrier():
	if Input.is_action_just_pressed("Claw") && break_barrier:
		collision.get_parent().queue_free()
