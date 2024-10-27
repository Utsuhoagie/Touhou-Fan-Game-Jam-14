extends Node

@onready var level_bgm: AudioStreamPlayer2D = $LevelBGM

@onready var button_hover_sfx: AudioStreamPlayer2D = $ButtonHoverSFX
@onready var button_select_sfx: AudioStreamPlayer2D = $ButtonSelectSFX
@onready var enter_level_sfx: AudioStreamPlayer2D = $EnterLevelSFX
@onready var death_sfx: AudioStreamPlayer2D = $DeathSFX
@onready var footstep_sfx: AudioStreamPlayer2D = $FootstepSFX
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var landing_sfx: AudioStreamPlayer2D = $LandingSFX
@onready var attack_sfx: AudioStreamPlayer2D = $AttackSFX
@onready var enemy_death_sfx: AudioStreamPlayer2D = $EnemyDeathSFX
@onready var trampoline_sfx: AudioStreamPlayer2D = $TrampolineSFX
@onready var level_complete_sfx: AudioStreamPlayer2D = $LevelCompleteSFX

func play_death_sfx() -> void:
	death_sfx.play()
	

func play_level_complete_sfx() -> void:
	level_complete_sfx.play()
	

func play_button_hover_sfx() -> void:
	button_hover_sfx.play()
	

func play_button_select_sfx() -> void:
	button_select_sfx.play()
	

func play_enter_level_sfx() -> void:
	enter_level_sfx.play()
	

func play_jump_sfx() -> void:
	jump_sfx.play()
	

func play_landing_sfx(tilemap: TileMapLayer, player_pos: Vector2) -> void:
	var tile_of_interest_coords: Vector2i = tilemap.local_to_map(player_pos)
	var floor_tile_data: TileData = tilemap.get_cell_tile_data(tile_of_interest_coords + Vector2i(0, 1))
	
	print(floor_tile_data.texture_origin)
	
	if floor_tile_data:
		landing_sfx.play()
	else:
		trampoline_sfx.play()
	

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
	

func start() -> void:
	level_bgm.play()
	

func stop() -> void:
	level_bgm.stop()
	
