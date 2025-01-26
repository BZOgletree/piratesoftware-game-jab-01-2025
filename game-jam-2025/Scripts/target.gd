extends CharacterBody2D

@export var player: Node2D
@export var speed: int
@export var escape_location: Node2D
@export var escape_waypoint_1: Node2D
@export var escape_waypoint_2: Node2D
@export var escape_waypoint_3: Node2D
@export var escape_waypoint_4: Node2D
@export var escape_waypoint_5: Node2D
@export var number_of_waypoints_prior_to_escape: int
@onready var nav_agent := $NavigationAgent2D

enum state {
	IDLE = 100,
	ALERT = 250,
	PANIC = 300
}

var current_escape_waypoint_location = 1
var target_position


func _ready() -> void:
	speed = state.IDLE

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	if speed == state.ALERT:
		makePath()
	move_and_slide()
	var current_position = self.translate
	if (target_position != null):
		print(target_position.position)

func makePath():
	if current_escape_waypoint_location == 1:
		nav_agent.target_position = escape_waypoint_1.global_position
		target_position = escape_waypoint_1.global_position
	elif current_escape_waypoint_location == 2 && number_of_waypoints_prior_to_escape != 1:
		nav_agent.target_position = escape_waypoint_2.global_position
		target_position = escape_waypoint_2.global_position
	elif current_escape_waypoint_location == 3 && number_of_waypoints_prior_to_escape != 2:
		nav_agent.target_position = escape_waypoint_3.global_position
		target_position = escape_waypoint_3.global_position
	elif current_escape_waypoint_location == 4 && number_of_waypoints_prior_to_escape != 3:
		nav_agent.target_position = escape_waypoint_4.global_position
		target_position = escape_waypoint_4.global_position
	elif current_escape_waypoint_location == 5 && number_of_waypoints_prior_to_escape != 4:
		nav_agent.target_position = escape_waypoint_5.global_position
		target_position = escape_waypoint_5.global_position
	else:
		nav_agent.target_position = escape_location.global_position
		target_position = escape_location.global_position


func _on_alert_radius_area_entered(area: Area2D) -> void:
	print('Alerted')
	self.speed = state.ALERT
	print(self.speed)

func _on_alert_radius_area_exited(area: Area2D) -> void:
	self.speed = state.IDLE
	print('Idle')
