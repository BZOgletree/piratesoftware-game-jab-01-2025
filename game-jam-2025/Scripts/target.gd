extends CharacterBody2D

@export var player: Node2D
@export var speed: int
@export var escape_location: Node2D
@onready var nav_agent := $NavigationAgent2D

enum state {
	IDLE = 100,
	ALERT = 250,
	PANIC = 300
}

func _ready() -> void:
	speed = state.IDLE

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	if speed == state.IDLE:
		makePath()
	move_and_slide()

func makePath():
	nav_agent.target_position = player.global_position

func _on_alert_radius_area_entered(area: Area2D) -> void:
	print('Alerted')
	self.speed = state.IDLE
	print(self.speed)

func _on_alert_radius_area_exited(area: Area2D) -> void:
	self.speed = state.IDLE
	print('Idle')
