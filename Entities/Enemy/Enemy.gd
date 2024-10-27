class_name Enemy
extends CharacterBody2D

@export var SPEED = 30.0

enum Direction { Left, Right }

@export var initialDirection: Direction
var currentDirection := 1

@export var mirror_y: bool = false

@onready var Flippable := $Flippable
@onready var FloorDetect := $Flippable/FloorDetect


func die() -> void:
	queue_free()
	Signals.enemy_died.emit()


func _ready() -> void:
	currentDirection = 1 if initialDirection == Direction.Right else -1
	$Flippable/AnimatedSprite2D.play("default")

	if mirror_y:
		up_direction = Vector2.DOWN
		Flippable.scale.y *= -1


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		var gravity_delta := get_gravity() * delta
		if mirror_y:
			gravity_delta *= -1
		velocity += gravity_delta

	if is_on_floor() and not FloorDetect.has_overlapping_bodies():
		currentDirection *= -1

	velocity.x = currentDirection * SPEED
	Flippable.scale.x = -currentDirection

	move_and_slide()


func _on_wall_detect_body_entered(body: Node2D) -> void:
	currentDirection *= -1


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		Signals.hazard_touched.emit()
