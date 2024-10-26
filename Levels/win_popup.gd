extends PanelContainer
class_name WinPopup

signal return_to_menu
signal to_next_level

@onready var return_button: Button = %ReturnButton
@onready var replay_button: Button = %ReplayButton
@onready var next_level_button: Button = %NextLevelButton


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	replay_button.pressed.connect(_on_replay_button_pressed)
	next_level_button.pressed.connect(_on_next_level_button_pressed)
	
	replay_button.grab_focus()
	

func _on_return_button_pressed() -> void:
	return_to_menu.emit()
	

func _on_replay_button_pressed() -> void:
	get_tree().reload_current_scene()
	

func _on_next_level_button_pressed() -> void:
	to_next_level.emit()
	
