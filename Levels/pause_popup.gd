extends PanelContainer
class_name PausePopup

signal restart_level
signal return_to_menu

@onready var return_button: Button = %ReturnButton
@onready var restart_button: Button = %RestartButton
@onready var continue_button: Button = %ContinueButton


func _ready() -> void:
	return_button.pressed.connect(_return_to_menu)
	restart_button.pressed.connect(_restart_level)
	continue_button.pressed.connect(_continue_level)
	
	return_button.focus_entered.connect(LevelBGMManager.play_button_hover_sfx)
	restart_button.focus_entered.connect(LevelBGMManager.play_button_hover_sfx)
	continue_button.focus_entered.connect(LevelBGMManager.play_button_hover_sfx)
	
	continue_button.grab_focus()
	

func _unhandled_key_input(event: InputEvent) -> void:
	# press esc again to unpause
	if event.is_action_pressed("ui_cancel") and not event.is_echo():
		_continue_level()
	

func _return_to_menu() -> void:
	LevelBGMManager.play_button_select_sfx()
	return_to_menu.emit()
	

func _restart_level() -> void:
	LevelBGMManager.play_button_select_sfx()
	LevelBGMManager.restore_volume()
	restart_level.emit()
	

func _continue_level() -> void:
	LevelBGMManager.play_button_select_sfx()
	LevelBGMManager.restore_volume()
	get_tree().paused = false
	self.queue_free()
	
