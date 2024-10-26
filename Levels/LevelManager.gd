extends Node2D

@export_file var next_level_path: String

const MAIN_MENU_PATH: String = "res://Menus/main_menu.tscn"

var win_popup_scene = preload("res://Levels/win_popup.tscn")

func _ready() -> void:
	Signals.hazard_touched.connect(reset_level)

	var player_instances: Array = get_tree().get_nodes_in_group("players")
	for player: Player in player_instances:
		if player.type != player.PlayerType.Shadow:
			continue

		player.shadow_merged.connect(_check_win_condition)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_level()

func _check_win_condition() -> void:
	if get_tree().get_node_count_in_group("players") > 2: return
	
	print("level complete!")
	
	# display win screen popup thing
	var win_popup := win_popup_scene.instantiate()
	win_popup.return_to_menu.connect(_return_to_menu)
	win_popup.to_next_level.connect(_load_next_level)
	
	get_node("CanvasLayer").add_child(win_popup)
	if not next_level_path:
		win_popup.next_level_button.hide()
	
	# ideally i want the mirrors to deactivate and the player
	# to lose control of the character, but i'll just put this for now
	get_tree().paused = true
	

func reset_level() -> void:
	get_tree().reload_current_scene()

func _return_to_menu() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
	

func _load_next_level() -> void:
	if not next_level_path: return
	
	get_tree().change_scene_to_file(next_level_path)
	
