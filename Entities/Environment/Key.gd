class_name Key
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.inventory.append(get_instance_id())

		var icon := TextureRect.new()
		var sprite_frames := ($AnimatedSprite2D as AnimatedSprite2D).sprite_frames
		icon.texture = sprite_frames.get_frame_texture("default", 0)
		get_node("%Inventory").add_child(icon)
		queue_free()
