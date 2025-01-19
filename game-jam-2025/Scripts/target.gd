extends CharacterBody2D

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D

enum state {
	IDLE = 200,
	ALERT = 250,
	PANIC = 300
}
var current_state = state.IDLE

# Called when the node enters the scene tree for the first time.

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	print(player.global_position)
	velocity = -dir * current_state
	move_and_slide()

func makePath():
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makePath()
