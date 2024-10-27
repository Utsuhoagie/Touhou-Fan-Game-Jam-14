extends Node2D

@export_file var next_level_path: String

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

const MAIN_MENU_PATH: String = "res://Menus/main_menu.tscn"
var pause_popup_scene = preload("res://Levels/pause_popup.tscn")
var win_popup_scene = preload("res://Levels/win_popup.tscn")

func _ready() -> void:
	Signals.hazard_touched.connect(reset_level)
	Signals.enemy_died.connect(_check_win_condition)

	var player_instances: Array = get_tree().get_nodes_in_group("players")
	for player: Player in player_instances:
		if player.type != player.PlayerType.Shadow:
			continue

		player.shadow_merged.connect(_check_win_condition)
	
	get_tree().paused = false
	animation_player.play("transition_in")
	


func _unhandled_key_input(event: InputEvent) -> void:
	# we don't want extra inputs pls
	if event.is_echo(): return

	if event.is_action_pressed("Reset"):
		reset_level()
	elif (event.is_action_pressed("ui_cancel")
	and not has_node("CanvasLayer/PausePopup")):
		# pause the game
		var pause_popup := pause_popup_scene.instantiate()
		pause_popup.return_to_menu.connect(_return_to_menu)

		canvas_layer.add_child(pause_popup)
		get_tree().paused = true


func _check_win_condition() -> void:
	var remaining_players := get_tree().get_nodes_in_group("players")	\
		.filter(func(player: Player): return not player.is_queued_for_deletion())

	var remaining_enemies := get_tree().get_nodes_in_group("enemies")	\
		.filter(func(enemy: Enemy): return not enemy.is_queued_for_deletion())

	if remaining_players.size() > 1 or not remaining_enemies.is_empty():
		return

	print("level complete!")

	# display win screen popup thing
	var win_popup := win_popup_scene.instantiate()
	win_popup.return_to_menu.connect(_return_to_menu)
	win_popup.to_next_level.connect(_load_next_level)

	canvas_layer.add_child(win_popup)
	if not next_level_path:
		win_popup.next_level_button.hide()

	# ideally i want the mirrors to deactivate and the player
	# to lose control of the character, but i'll just put this for now
	get_tree().paused = true


func reset_level() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene.call_deferred()


func _return_to_menu() -> void:
	get_tree().paused = false
	
	animation_player.play("transition_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(MAIN_MENU_PATH)


func _load_next_level() -> void:
	if not next_level_path: return
	
	animation_player.play("transition_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(next_level_path)
