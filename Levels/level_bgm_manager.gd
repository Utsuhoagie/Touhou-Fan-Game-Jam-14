extends Node

@onready var level_bgm: AudioStreamPlayer2D = $LevelBGM
@onready var tutorial_bgm: AudioStreamPlayer2D = $TutorialBGM

@onready var button_hover_sfx: AudioStreamPlayer2D = $ButtonHoverSFX
@onready var button_select_sfx: AudioStreamPlayer2D = $ButtonSelectSFX
@onready var enter_level_sfx: AudioStreamPlayer2D = $EnterLevelSFX
@onready var death_sfx: AudioStreamPlayer2D = $DeathSFX
@onready var footstep_sfx: AudioStreamPlayer2D = $FootstepSFX
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var landing_sfx: AudioStreamPlayer2D = $LandingSFX
@onready var attack_sfx: AudioStreamPlayer2D = $AttackSFX
@onready var enemy_death_sfx: AudioStreamPlayer2D = $EnemyDeathSFX
@onready var mirror_sfx: AudioStreamPlayer2D = $MirrorSFX
@onready var trampoline_sfx: AudioStreamPlayer2D = $TrampolineSFX
@onready var level_complete_sfx: AudioStreamPlayer2D = $LevelCompleteSFX
@onready var item_collect_sfx: AudioStreamPlayer2D = $ItemCollectSFX
@onready var door_unlock_sfx: AudioStreamPlayer2D = $DoorUnlockSFX

var current_level: int = 0


func play_death_sfx() -> void:
	death_sfx.play()
	

func play_level_complete_sfx() -> void:
	level_complete_sfx.play()
	

func play_button_hover_sfx() -> void:
	button_hover_sfx.play()
	

func play_button_select_sfx() -> void:
	button_select_sfx.play()
	

func play_item_collect_sfx() -> void:
	item_collect_sfx.play()
	

func play_mirror_sfx() -> void:
	mirror_sfx.play()
	

func play_door_unlock_sfx() -> void:
	door_unlock_sfx.play()
	

func play_enter_level_sfx() -> void:
	enter_level_sfx.play()
	

func play_jump_sfx() -> void:
	jump_sfx.play()
	

func play_landing_sfx(tilemap: TileMapLayer, player_pos: Vector2) -> void:
	var tile_of_interest_coords: Vector2i = tilemap.local_to_map(player_pos)
	var floor_tile_data: TileData = tilemap.get_cell_tile_data(tile_of_interest_coords + Vector2i(0, 1))
	
	# print(floor_tile_data.texture_origin)
	
	if floor_tile_data and floor_tile_data.get_custom_data("Trampoline") == true:
		trampoline_sfx.play()
	else:
		landing_sfx.play()
	

func play_attack_sfx() -> void:
	if not attack_sfx.playing:
		attack_sfx.play()
	

func play_enemy_death_sfx() -> void:
	if not enemy_death_sfx.playing:
		enemy_death_sfx.play()
	

func play_footstep_sfx() -> void:
	if not footstep_sfx.playing:
		footstep_sfx.play()
	

func stop_footstep_sfx() -> void:
	if footstep_sfx.playing:
		footstep_sfx.stop()
	

func dim_volume() -> void:
	if current_level >= 7:
		level_bgm.volume_db = -10
	else:
		tutorial_bgm.volume_db = -10
	

func restore_volume() -> void:
	if current_level >= 7:
		level_bgm.volume_db = 0
	else:
		tutorial_bgm.volume_db = 0
	

func start(level: int) -> void:
	current_level = level
	
	if current_level >= 7:
		level_bgm.play()
	else:
		tutorial_bgm.play()
	

func stop() -> void:
	level_bgm.volume_db = 0
	tutorial_bgm.volume_db = 0
	level_bgm.stop()
	tutorial_bgm.stop()
	

func inc_level_counter() -> void:
	current_level += 1
	
	if current_level >= 7:
		# tween volume or smth idk
		level_bgm.volume_db = -20
		level_bgm.play()
		
		var tween = get_tree().create_tween().set_parallel(true)
		(tween.tween_property(tutorial_bgm, "volume_db", -20, 1)
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR))
		(tween.tween_property(level_bgm, "volume_db", 0, 1)
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR))
		
		tutorial_bgm.play()
	
