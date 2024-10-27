extends Button
class_name LevelButton

signal level_selected(chosen_level_path: String)

@export_file var level_path: String

@onready var select_sfx: AudioStreamPlayer2D = $SelectSFX
@onready var hover_sfx: AudioStreamPlayer2D = $HoverSFX

func _ready() -> void:
	self.pressed.connect(_level_selected)
	self.focus_entered.connect(hover_sfx.play)
	

func _level_selected() -> void:
	print_debug("Player has selected level: " + level_path)
	
	select_sfx.play()
	level_selected.emit(level_path)
	
