extends Area2D
class_name Sign

@export var help_popup: HelpPopup

@onready var hint: Label = $Hint

var status: String = "inactive"

func _ready() -> void:
	self.body_entered.connect(_player_entered)
	self.body_exited.connect(_player_exited)
	
	hint.hide()
	

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_echo(): return
	
	if event.is_action_pressed("ui_accept"):
		if status == "standby":
			help_popup.show()
			status = "reading"
		elif status == "reading":
			help_popup.hide()
			status = "standby"
	

func _player_entered(body: Player) -> void:
	print("test")
	hint.show()
	status = "standby"
	

func _player_exited(body: Player) -> void:
	hint.hide()
	status = "inactive"
	
	if help_popup.visible:
		help_popup.hide()
	
