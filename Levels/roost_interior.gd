extends Node2D

const heart_purchasable = preload("res://Interactables/heart_store_pickup.tscn")
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}
@onready var pause_menu = $CanvasLayer/PauseMenu
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DialogueTracker.rocco_progress == QUESTING:
		$heartpickup.queue_free()

	NavigationManager.current_level = "res://Levels/roost_interior.tscn"
	GlobalAudio.play_interior_music()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
