extends Control

@onready var animations = $AnimationPlayer
@onready var noises = $AudioStreamPlayer
@onready var player = $"../../PlayerPanda"

func _ready():
	animations.play("RESET")

# Called when the node enters the scene tree for the first time.
func resume():
	get_tree().paused = false
	visible = false
	animations.play_backwards("blur")

	
func save_game():	
	var saved_game: SavedGame = SavedGame.new()
	
	#player singletons and position
	saved_game.player_health = PlayerStats.health
	saved_game.player_position = player.global_position
	saved_game.player_max_health = PlayerStats.max_health
	saved_game.current_level = NavigationManager.current_level
	saved_game.player_wallet = Wallet.wallet
	saved_game.player_sword_damage = PlayerStats.sword_damage
	#saves all dialogue options and quest progress in the world
	saved_game.dialogue_saver.append(DialogueTracker.mayor_progress)
	saved_game.dialogue_saver.append(DialogueTracker.well_progress)
	saved_game.dialogue_saver.append(DialogueTracker.darpie_progress)
	saved_game.dialogue_saver.append(DialogueTracker.guard_progress)
	saved_game.dialogue_saver.append(DialogueTracker.tanuki_met)
	saved_game.dialogue_saver.append(DialogueTracker.tanuki_progress)
	saved_game.dialogue_saver.append(DialogueTracker.key_progress)
	saved_game.dialogue_saver.append(DialogueTracker.grapple_chest)
	saved_game.dialogue_saver.append(DialogueTracker.whetstone_progress)
	saved_game.dialogue_saver.append(DialogueTracker.temple_nuts_chest_progress)
	saved_game.dialogue_saver.append(DialogueTracker.temple_boss_progress)
	saved_game.dialogue_saver.append(DialogueTracker.doe_progress)
	saved_game.dialogue_saver.append(DialogueTracker.fen_progress)
	saved_game.dialogue_saver.append(DialogueTracker.tink_progress)
	saved_game.dialogue_saver.append(DialogueTracker.mrbrie_progress)
	saved_game.dialogue_saver.append(DialogueTracker.msbrie_progress)
	ResourceSaver.save(saved_game, "user://savegame.tres")
func load_game():
	
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
	player.global_position = saved_game.player_position



func pause():
	get_tree().paused = true
	visible = true
	animations.play("blur")
	
	
func pausePressed():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_resume_pressed() -> void:
	resume()
	noises.play()
	
func _on_save_pressed() -> void:
	noises.play()
	save_game()

func _on_quit_pressed() -> void:
	resume()
	noises.play()
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")
	
	
func _process(delta: float) -> void:
	pausePressed()


func _on_load_pressed() -> void:
	noises.play()
	load_game()
