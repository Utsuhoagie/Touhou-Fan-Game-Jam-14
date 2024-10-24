class_name Player
extends CharacterBody2D

# Stats
const SPEED = 300.0
const JUMP_VELOCITY = -450.0

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


func _ready() -> void:
	if mirror_y:
		up_direction = Vector2.DOWN
		AnimSprite.flip_v = mirror_y


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		var gravity_delta = get_gravity() * delta
		if mirror_y:
			gravity_delta.y *= -1

		velocity += gravity_delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if mirror_y:
			velocity.y *= -1

	_handle_direction(delta)

	move_and_slide()


func _handle_direction(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")

	if not direction:
		velocity.x = 0
		AnimSprite.stop()
		return

	var actual_direction := direction
	if mirror_x:
		actual_direction *= -1

	velocity.x = actual_direction * SPEED

	AnimSprite.play("default")
	AnimSprite.flip_h = actual_direction > 0


func merge_into_main():
	if type == PlayerType.Main:
		var merged: Node2D = $"../Merged"
		global_position = merged.global_position
	elif type == PlayerType.Shadow:
		queue_free()
