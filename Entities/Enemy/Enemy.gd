class_name Enemy
extends CharacterBody2D

@export var SPEED = 30.0
var currentDirection := 1

@onready var Flippable := $Flippable
@onready var FloorDetect := $Flippable/FloorDetect


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

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
