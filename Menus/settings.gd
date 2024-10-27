extends CanvasLayer
class_name Settings

@onready var return_button: Button = %ReturnButton


func _ready() -> void:
	return_button.pressed.connect(_return_to_menu)
	return_button.grab_focus()
	

func _return_to_menu() -> void:
	self.queue_free()
	
