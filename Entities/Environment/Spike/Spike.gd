class_name Spike
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Signals.hazard_touched.emit()
