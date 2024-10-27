class_name Door
extends Node2D

@export var key_to_unlock: Key
@onready var key_to_unlock_id := key_to_unlock.get_instance_id()


func _ready() -> void:
	modulate = key_to_unlock.modulate


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		if player.inventory.has(key_to_unlock_id):
			queue_free()
