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

@export var target_skin_blue_hair: AnimatedSprite2D
@export var target_skin_blue: AnimatedSprite2D
@export var target_skin_red_hair: AnimatedSprite2D
@export var target_skin_red: AnimatedSprite2D
@export var target_skin_green_hair: AnimatedSprite2D
@export var target_skin_green: AnimatedSprite2D
@export var target_skin_teal_hair: AnimatedSprite2D
@export var target_skin_teal: AnimatedSprite2D
@export var target_skin_doc: AnimatedSprite2D
@export var target_skin_army: AnimatedSprite2D

@export var current_skin: int
@export var starting_state: int
var currently_selected_skin

enum state {
	IDLE = 75,
	ALERT = 125,
	PANIC = 175
}

var current_escape_waypoint_location = 1
var target_position

func _ready() -> void:
	if starting_state == 1:
		speed = state.ALERT
	elif starting_state == 2:
		speed = state.PANIC
	else:
		speed = state.IDLE
	pickSkin()

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	get_sprite_position(velocity)
	makePath()
	move_and_slide()
	if nav_agent.distance_to_target() < 5:
		if self.speed == state.IDLE && workstation_waypoint_1 != null:
			next_workstation = 2 if next_workstation == 1 else 1
		else:
			current_escape_waypoint_location += 1

func makePath():
	if self.speed == state.IDLE:
		if workstation_waypoint_1 == null:
			pass
		elif next_workstation == 1:
			nav_agent.target_position = workstation_waypoint_1.global_position
		else:
			nav_agent.target_position = workstation_waypoint_2.global_position
	elif current_escape_waypoint_location == 1:
		nav_agent.target_position = escape_waypoint_1.global_position
		target_position = escape_waypoint_1.global_position
	elif current_escape_waypoint_location == 2:
		nav_agent.target_position = escape_waypoint_2.global_position
		target_position = escape_waypoint_2.global_position
	elif current_escape_waypoint_location == 3:
		nav_agent.target_position = escape_waypoint_3.global_position
		target_position = escape_waypoint_3.global_position
	elif current_escape_waypoint_location == 4:
		nav_agent.target_position = escape_waypoint_4.global_position
		target_position = escape_waypoint_4.global_position
	elif current_escape_waypoint_location == 5:
		nav_agent.target_position = escape_waypoint_5.global_position
		target_position = escape_waypoint_5.global_position
	else:
		nav_agent.target_position = escape_location.global_position
		target_position = escape_location.global_position


func _on_alert_radius_area_entered(area: Area2D) -> void:
	if area.get_parent() == player:
		pickSkin()
		self.speed = state.ALERT if self.speed == state.IDLE else state.PANIC
	if escape_location == area:
		speed = 0
		queue_free()

func pickSkin():
	if current_skin == 1:
		target_skin_blue_hair.visible = true
		target_skin_blue_hair.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_blue_hair.play()
		currently_selected_skin = target_skin_blue_hair
	elif current_skin == 2:
		target_skin_blue.visible = true
		target_skin_blue.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_blue.play()
		currently_selected_skin = target_skin_blue
	elif current_skin == 3:
		target_skin_red_hair.visible = true
		target_skin_red_hair.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_red_hair.play()
		currently_selected_skin = target_skin_red_hair
	elif current_skin == 4:
		target_skin_red.visible = true
		target_skin_red.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_red.play()
		currently_selected_skin = target_skin_red
	elif current_skin == 5:
		target_skin_green_hair.visible = true
		target_skin_green_hair.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_green_hair.play()
		currently_selected_skin = target_skin_green_hair
	elif current_skin == 6:
		target_skin_green.visible = true
		target_skin_green.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_green.play()
		currently_selected_skin = target_skin_green
	elif current_skin == 7:
		target_skin_teal_hair.visible = true
		target_skin_teal_hair.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_teal_hair.play()
		currently_selected_skin = target_skin_teal_hair
	elif current_skin == 8:
		target_skin_teal.visible = true
		target_skin_teal.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_teal.play()
		currently_selected_skin = target_skin_teal
	elif current_skin == 9:
		target_skin_doc.visible = true
		target_skin_doc.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_doc.play()
		currently_selected_skin = currently_selected_skin
	elif current_skin == 10:
		target_skin_army.visible = true
		target_skin_army.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_army.play()
		currently_selected_skin = target_skin_army
	else:
		target_skin_blue.visible = true
		target_skin_blue.animation = 'Walking' if speed == state.IDLE else 'Running'
		target_skin_blue.play()
		currently_selected_skin = target_skin_blue

func get_sprite_position(velocity):
	pickSkin()
	if velocity.x > 0:
		currently_selected_skin.rotation_degrees = 90
	if velocity.y > 0:
		currently_selected_skin.rotation_degrees = 180
	if velocity.y < 0:
		currently_selected_skin.rotation_degrees = 0
	if velocity.x < 0:
		currently_selected_skin.rotation_degrees = 270
