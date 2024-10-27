extends CanvasLayer
class_name Settings

@onready var return_button: Button = %ReturnButton


func _ready() -> void:
	return_button.pressed.connect(_return_to_menu)
	return_button.focus_entered.connect(LevelBGMManager.play_button_hover_sfx)
	return_button.grab_focus()
	

func _return_to_menu() -> void:
	LevelBGMManager.play_button_select_sfx()
	self.queue_free()
	
