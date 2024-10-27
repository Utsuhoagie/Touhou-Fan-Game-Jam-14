class_name Seija
extends Area2D

@export var HP: int
var current_HP: int

@onready var attack_timer: Timer = $Timer
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_col: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var hitbox_sprite: AnimatedSprite2D = $Hitbox/AnimatedSprite2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var HPBar: ProgressBar = $Control/HPBar


func _ready() -> void:
	current_HP = HP
	attack_timer.timeout.connect(attack)
	sprite.play("default")

	HPBar.value = 100


func take_damage() -> void:
	current_HP -= 5
	HPBar.value = current_HP

	print("HP = %s" % current_HP)
	if current_HP <= 0:
		queue_free()
		Signals.Seija_died.emit()


func attack() -> void:
	hitbox_sprite.visible = true
	hitbox_sprite.play("default")



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Signals.hazard_touched.emit()


func _on_detect_player_body_entered(body: Node2D) -> void:
	if body is Player:
		attack_timer.start()
		if hitbox_col.disabled:
			attack.call_deferred()


func _on_animated_sprite_2d_animation_finished() -> void:
	hitbox_col.disabled = true
	hitbox_sprite.visible = false


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		Signals.hazard_touched.emit()


func _on_animated_sprite_2d_frame_changed() -> void:
	if hitbox_sprite.frame == 2:
		hitbox_col.disabled = false
