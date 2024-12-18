extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const MAIN_MENU_PATH: String = "res://Menus/main_menu.tscn"
const opening_sequence: Array[String] = [
	"opening_1", "opening_2", "opening_3", "opening_4", "opening_5"
]
var sequence_counter: int = 0


func _ready() -> void:
	animation_player.play(opening_sequence[sequence_counter])
	

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_echo() or animation_player.is_playing(): return
	
	if event.is_action_pressed("ui_accept"):
		sequence_counter += 1
		animation_player.play(opening_sequence[sequence_counter])
		
		if sequence_counter == 4:
			$Label.hide()
			await animation_player.animation_finished
			get_tree().change_scene_to_file(MAIN_MENU_PATH)
			
	elif event.is_action_pressed("ui_cancel"):
		$Label.hide()
		animation_player.play(opening_sequence[4])
		await animation_player.animation_finished
		get_tree().change_scene_to_file(MAIN_MENU_PATH)
		
