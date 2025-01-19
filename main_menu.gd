extends Control

@onready var starter = $VBoxContainer/StartButton
#@onready var player = $"../../PlayerPanda"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	starter.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_load_button_pressed() -> void:
	NavigationManager.spawn_door_tag = null
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	get_tree().paused = false
	visible = false
	#player.global_position = saved_game.player_position
	PlayerStats.health = saved_game.player_health
	PlayerStats.max_health = saved_game.player_max_health
	Wallet.wallet = saved_game.player_wallet
	PlayerStats.sword_damage = saved_game.player_sword_damage
	DialogueTracker.mayor_progress = saved_game.dialogue_saver[0]
	DialogueTracker.well_progress = saved_game.dialogue_saver[1]
	DialogueTracker.darpie_progress = saved_game.dialogue_saver[2]
	DialogueTracker.guard_progress = saved_game.dialogue_saver[3]
	DialogueTracker.tanuki_met = saved_game.dialogue_saver[4]
	DialogueTracker.tanuki_progress = saved_game.dialogue_saver[5]
	DialogueTracker.key_progress = saved_game.dialogue_saver[6]
	DialogueTracker.grapple_chest = saved_game.dialogue_saver[7]
	DialogueTracker.whetstone_progress = saved_game.dialogue_saver[8]
	DialogueTracker.temple_nuts_chest_progress = saved_game.dialogue_saver[9]
	DialogueTracker.temple_boss_progress = saved_game.dialogue_saver[10]
	DialogueTracker.doe_progress = saved_game.dialogue_saver[11]
	DialogueTracker.fen_progress = saved_game.dialogue_saver[12]
	DialogueTracker.tink_progress = saved_game.dialogue_saver[13]
	DialogueTracker.mrbrie_progress = saved_game.dialogue_saver[14]
	DialogueTracker.msbrie_progress = saved_game.dialogue_saver[15]
	TransitionScreen.transition()
	get_tree().change_scene_to_file(saved_game.current_level)
	#player.global_position = saved_game.player_position
