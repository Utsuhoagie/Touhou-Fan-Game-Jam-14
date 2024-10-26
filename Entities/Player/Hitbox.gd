class_name Hitbox
extends Area2D

@onready var Col := $CollisionShape2D
@onready var Sprite := $AnimatedSprite2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Action"):
		Col.disabled = false
		Sprite.visible = true
		Sprite.play("default")

func _on_animated_sprite_2d_animation_finished() -> void:
	Col.disabled = true
	Sprite.visible = false


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		var enemy: Enemy = body
		enemy.die()
