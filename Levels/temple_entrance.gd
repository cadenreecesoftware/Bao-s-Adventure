extends Node2D
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}
var player_in_area = false

@onready var pause_menu = $CanvasLayer/PauseMenu
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NavigationManager.current_level = "res://Levels/temple_entrance.tscn"
	PlayerPause.playerPaused = false
	if GlobalAudio.current_music != "forest_music1":
		GlobalAudio.play_forest_music_level()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
