extends CharacterBody2D

@export var player: Node2D
@export var speed: int
@export var escape_location: Node2D
@export var escape_waypoint_1: Node2D
@export var escape_waypoint_2: Node2D
@export var escape_waypoint_3: Node2D
@export var escape_waypoint_4: Node2D
@export var escape_waypoint_5: Node2D
@export var workstation_waypoint_1: Node2D
@export var workstation_waypoint_2: Node2D
@export var next_workstation: int
@onready var nav_agent := $NavigationAgent2D

enum state {
	IDLE = 75,
	ALERT = 150,
	PANIC = 200
}

var current_escape_waypoint_location = 1
var target_position


func _ready() -> void:
	speed = state.IDLE

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	makePath()
	move_and_slide()
	var current_position = self.translate
	#if nav_agent.distance_to_target() < 5:
		#if self.speed == state.IDLE:
			#next_workstation = 2 if next_workstation == 1 else 1
		#else:
			#current_escape_waypoint_location += 1

func makePath():
	nav_agent.target_position = player.global_position
	#if self.speed == state.IDLE:
		#if workstation_waypoint_1 == null:
			#pass
		#elif next_workstation == 1:
			#nav_agent.target_position = workstation_waypoint_1.global_position
		#else:
			#nav_agent.target_position = workstation_waypoint_2.global_position
	#elif current_escape_waypoint_location == 1:
		#nav_agent.target_position = escape_waypoint_1.global_position
		#target_position = escape_waypoint_1.global_position
	#elif current_escape_waypoint_location == 2:
		#nav_agent.target_position = escape_waypoint_2.global_position
		#target_position = escape_waypoint_2.global_position
	#elif current_escape_waypoint_location == 3:
		#nav_agent.target_position = escape_waypoint_3.global_position
		#target_position = escape_waypoint_3.global_position
	#elif current_escape_waypoint_location == 4:
		#nav_agent.target_position = escape_waypoint_4.global_position
		#target_position = escape_waypoint_4.global_position
	#elif current_escape_waypoint_location == 5:
		#nav_agent.target_position = escape_waypoint_5.global_position
		#target_position = escape_waypoint_5.global_position
	#else:
		#nav_agent.target_position = escape_location.global_position
		#target_position = escape_location.global_position


func _on_alert_radius_area_entered(area: Area2D) -> void:
	if area.get_parent() == player:
		self.speed = state.ALERT
	if escape_location == area:
		speed = 0
		await get_tree().create_timer(2.0).timeout
		queue_free()
