extends PanelContainer
class_name HelpPopup

@export_multiline var help_text: String = "placeholder text"

@onready var help_label: Label = %HelpLabel

func _ready() -> void:
	help_label.text = help_text
	self.hide()
	
