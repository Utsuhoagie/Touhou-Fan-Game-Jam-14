extends Node2D

func _ready() -> void:
	Signals.hazard_touched.connect(reset_level)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_level()

func reset_level() -> void:
	#return

	get_tree().reload_current_scene()
