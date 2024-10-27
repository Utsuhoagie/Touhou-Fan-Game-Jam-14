extends CanvasLayer
class_name MainMenu

@onready var button_hover_sfx: AudioStreamPlayer2D = $ButtonHoverSFX
@onready var contents: Control = $Contents
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = %PlayButton
@onready var settings_button: Button = %SettingsButton
@onready var exit_button: Button = %ExitButton

var level_select_scene = preload("res://Menus/level_select.tscn")
var settings_scene = preload("res://Menus/settings.tscn")

func _ready() -> void:
	play_button.pressed.connect(_enter_level_select)
	settings_button.pressed.connect(_enter_settings)
	exit_button.pressed.connect(_exit_game)
	
	play_button.focus_entered.connect(button_hover_sfx.play)
	settings_button.focus_entered.connect(button_hover_sfx.play)
	exit_button.focus_entered.connect(button_hover_sfx.play)
	
	animation_player.play("transition_in")
	await animation_player.animation_finished
	
	play_button.grab_focus()
	

func _enter_level_select() -> void:
	var level_select = level_select_scene.instantiate()
	get_tree().get_root().add_child(level_select)
	
	level_select.tree_exited.connect(_return_to_main_menu)
	contents.hide()
	

func _enter_settings() -> void:
	var settings = settings_scene.instantiate()
	get_tree().get_root().add_child(settings)
	
	settings.tree_exited.connect(_return_to_main_menu)
	contents.hide()
	

func _exit_game() -> void:
	get_tree().quit()
	

func _return_to_main_menu() -> void:
	contents.show()
	play_button.grab_focus()
	
