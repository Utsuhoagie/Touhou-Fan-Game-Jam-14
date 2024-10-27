extends Button
class_name LevelButton

signal level_selected(chosen_level_path: String)

@export_file var level_path: String

func _ready() -> void:
	self.pressed.connect(_level_selected)
	self.focus_entered.connect(LevelBGMManager.play_button_hover_sfx)
	

func _level_selected() -> void:
	print_debug("Player has selected level: " + level_path)
	
	LevelBGMManager.play_enter_level_sfx()
	level_selected.emit(level_path)
	
