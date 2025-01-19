extends Node2D

var player_in_area = false

@onready var pause_menu = $CanvasLayer/PauseMenu
var dialogue_cooldown = false
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NavigationManager.current_level = "res://Levels/cutscene_boss_room.tscn"
	PlayerPause.playerPaused = false
	if GlobalAudio.current_music != "temple_interior_music":
		GlobalAudio.play_temple_music()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)


func _on_credit_starter_body_entered(body: Node2D) -> void:
	if body is Player:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file.call_deferred("res://Levels/credits.tscn")
