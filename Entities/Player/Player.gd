class_name Player
extends CharacterBody2D

signal shadow_merged

# Stats
const SPEED: float = 250.0
const ACCEL: float = 1500.0
const JUMP_VELOCITY: float = -580.0
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
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var Flippable := $Flippable
@onready var AnimSprite := $Flippable/AnimatedSprite2D


func _ready() -> void:
	if not is_on_floor():
		AnimSprite.animation = "jump"
		AnimSprite.frame = 2

	if type == PlayerType.Shadow:
		AnimSprite.modulate = 0xaba5c4c3

	if mirror_y:
		up_direction = Vector2.DOWN
		Flippable.scale.y = -1


func _physics_process(delta: float) -> void:
	var was_on_floor: bool = is_on_floor()

	if not was_on_floor:
		var gravity_delta = get_gravity() * delta
		if mirror_y:
			gravity_delta.y *= -1

		velocity += gravity_delta

	if (Input.is_action_just_pressed("Jump")
	and (was_on_floor or not coyote_timer.is_stopped())):
		LevelBGMManager.play_jump_sfx()
		
		velocity.y = JUMP_VELOCITY
		if mirror_y:
			velocity.y *= -1
	elif Input.is_action_just_released("Jump"):
		if mirror_y and velocity.y > abs(JUMP_VELOCITY) / 1.75:
			velocity.y = abs(JUMP_VELOCITY) / 1.75
		elif not mirror_y and velocity.y < JUMP_VELOCITY / 1.75:
			velocity.y = JUMP_VELOCITY / 1.75
	
	_handle_direction(delta)
	
	if was_on_floor and velocity.x != 0 and type == PlayerType.Main:
		LevelBGMManager.play_footstep_sfx()
	if not was_on_floor or velocity.x == 0 and type == PlayerType.Main:
		LevelBGMManager.stop_footstep_sfx()
	
	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		coyote_timer.start()
	if not was_on_floor and is_on_floor():
		LevelBGMManager.play_landing_sfx(
			self.get_parent().find_child("TileMapLayer", false),
			self.global_position,
			self.mirror_y
		)
	

func _handle_direction(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")

	if not direction:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

		if is_on_floor():
			AnimSprite.play("default")
		elif AnimSprite.animation != "jump":
			AnimSprite.play("jump")
		return

	var actual_direction := direction
	if mirror_x:
		actual_direction *= -1

	# if is_on_floor():
	velocity.x = move_toward(velocity.x, actual_direction * SPEED, ACCEL * delta)
	# else:
	# 	velocity.x = move_toward(velocity.x, actual_direction * SPEED, AIR_ACCEL * delta)

	if is_equal_approx(velocity.y, 0.0):
		AnimSprite.play("walk")
	elif AnimSprite.animation != "jump":
		AnimSprite.play("jump")
	Flippable.scale.x = actual_direction


func merge_into_main():
	if type == PlayerType.Main:
		pass

		#var merged: Node2D = $"../Merged"
		#global_position = merged.global_position
	elif type == PlayerType.Shadow:
		LevelBGMManager.play_mirror_sfx()
		queue_free()
		shadow_merged.emit()
