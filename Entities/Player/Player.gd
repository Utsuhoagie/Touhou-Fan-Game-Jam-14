class_name Player
extends CharacterBody2D

signal shadow_merged

# Stats
const SPEED: float = 250.0
const ACCEL: float = 1500.0
const AIR_ACCEL: float = 1000.0
const JUMP_VELOCITY: float = -450.0
const FRICTION: float = 1500.0

enum PlayerType {
	Main,
	Shadow
}
@export var type: PlayerType = PlayerType.Main

@export var mirror_x: bool = false
@export var mirror_y: bool = false

# Inventory
var inventory: Array = []

# Nodes
@onready var AnimSprite := $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer


func _ready() -> void:
	if mirror_y:
		up_direction = Vector2.DOWN
		AnimSprite.flip_v = mirror_y


func _physics_process(delta: float) -> void:
	var was_on_floor: bool = is_on_floor()
	
	if not was_on_floor:
		var gravity_delta = get_gravity() * delta
		if mirror_y:
			gravity_delta.y *= -1

		velocity += gravity_delta

	if (Input.is_action_just_pressed("Jump")
	and (was_on_floor or not coyote_timer.is_stopped())):
		velocity.y = JUMP_VELOCITY
		if mirror_y:
			velocity.y *= -1
	elif Input.is_action_just_released("Jump"):
		if mirror_y and velocity.y > abs(JUMP_VELOCITY) / 1.75:
			velocity.y = abs(JUMP_VELOCITY) / 1.75
		elif not mirror_y and velocity.y < JUMP_VELOCITY / 1.75:
			velocity.y = JUMP_VELOCITY / 1.75

	_handle_direction(delta)

	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		coyote_timer.start()
		


func _handle_direction(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")

	if not direction:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		AnimSprite.stop()
		return

	var actual_direction := direction
	if mirror_x:
		actual_direction *= -1

	if is_on_floor():
		velocity.x = move_toward(velocity.x, actual_direction * SPEED, ACCEL * delta)
	else:
		velocity.x = move_toward(velocity.x, actual_direction * SPEED, AIR_ACCEL * delta)

	AnimSprite.play("default")
	AnimSprite.flip_h = actual_direction > 0


func merge_into_main():
	if type == PlayerType.Main:
		pass
		
		#var merged: Node2D = $"../Merged"
		#global_position = merged.global_position
	elif type == PlayerType.Shadow:
		shadow_merged.emit()
		queue_free()
