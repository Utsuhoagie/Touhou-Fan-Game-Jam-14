class_name Key
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.inventory.append(get_instance_id())

		var icon := TextureRect.new()
		var texture = load("res://Assets/Actual/KeyIcon.png")
		icon.texture = texture

		$"../CanvasLayer/Inventory".add_child(icon)
		LevelBGMManager.play_item_collect_sfx()
		queue_free()
