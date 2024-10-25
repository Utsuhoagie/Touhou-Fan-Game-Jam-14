extends CanvasLayer
class_name LevelSelect

@onready var back_button: Button = %BackButton
@onready var level_select_container: GridContainer = %LevelSelectContainer

const LEVELS_FOLDER_PATH: String = "res://Levels/Main/"

var levels_dir := DirAccess.open(LEVELS_FOLDER_PATH)

func _ready() -> void:
	back_button.pressed.connect(_return_to_main_menu)
	
	levels_dir.list_dir_begin()
	var level_file_name = levels_dir.get_next()
	var level_counter: int = 1
	
	while level_file_name != "":
		var new_level_button := LevelButton.new()
		new_level_button.text = str(level_counter)
		new_level_button.level_path = LEVELS_FOLDER_PATH + level_file_name
		new_level_button.level_selected.connect(_enter_level)
		# new_level_button.font_size = 32
		
		level_select_container.add_child(new_level_button)
		level_file_name = levels_dir.get_next()
		level_counter += 1
	
	# back_button.grab_focus()
	

func _return_to_main_menu() -> void:
	self.queue_free()
	

func _enter_level(chosen_level_path: String) -> void:
	print_debug("Loading level path: " + chosen_level_path)
	get_tree().change_scene_to_file(chosen_level_path)
	
	self.queue_free()
