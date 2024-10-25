extends Node2D

func _ready() -> void:
	var player_instances: Array = get_tree().get_nodes_in_group("players")
	for player: Player in player_instances:
		if player.type != player.PlayerType.Shadow:
			continue
		
		player.shadow_merged.connect(_check_win_condition)
		
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Action"):
		get_tree().reload_current_scene()
	

func _check_win_condition() -> void:
	if get_tree().get_node_count_in_group("players") > 2: return
	
	print("level complete!")
	
	# display win screen popup thing
	
