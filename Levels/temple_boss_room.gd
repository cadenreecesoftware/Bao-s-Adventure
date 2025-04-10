extends Node2D

var player_in_area = false

const boss_spawn = preload("res://Enemies/oni.tscn")
@onready var pause_menu = $CanvasLayer/PauseMenu
var dialogue_cooldown = false
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(DialogicSignal)
	NavigationManager.current_level = "res://Levels/temple_boss_room.tscn"
	PlayerPause.playerPaused = false
	if GlobalAudio.current_music != "temple_interior_music":
		GlobalAudio.play_temple_music()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
func DialogicSignal(arg: String):
	if arg == "exit_boss_dialogue":
		PlayerPause.playerPaused = false
		var boss = boss_spawn.instantiate()
		get_parent().add_child(boss)
		boss.global_position = $Boss_Spawner.global_position
	if arg == "exit_boss_beat":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Levels/cutscene_boss_room.tscn")
