extends Node

@onready var level_bgm: AudioStreamPlayer2D = $LevelBGM


func start() -> void:
	level_bgm.play()
	

func stop() -> void:
	level_bgm.stop()
	
