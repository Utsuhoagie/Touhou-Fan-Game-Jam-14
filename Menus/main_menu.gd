extends CanvasLayer
class_name MainMenu

@onready var play_button: Button = %PlayButton
@onready var credits_button: Button = %CreditsButton
@onready var exit_button: Button = %ExitButton

var level_select_scene = preload("res://Menus/level_select.tscn")

func _ready() -> void:
	play_button.pressed.connect(_enter_level_select)
	# credits_button.pressed.connect(_enter_level_select)
	exit_button.pressed.connect(_exit_game)
	
	play_button.grab_focus()
	

func _enter_level_select() -> void:
	var level_select = level_select_scene.instantiate()
	get_tree().get_root().add_child(level_select)
	
	level_select.tree_exited.connect(_return_to_main_menu)
	self.visible = false
	

func _exit_game() -> void:
	get_tree().quit()
	

func _return_to_main_menu() -> void:
	self.visible = true
	
