extends Node2D


enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}
var player_in_area = false

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var blem = $Blemmyae
@onready var house1_open = $"House1(open)"
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NavigationManager.current_level = "res://Levels/level_4.tscn"
	PlayerPause.playerPaused = false
	house1_open.visible = false
	if GlobalAudio.current_music != "forest_music1":
		GlobalAudio.play_forest_music_level()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	Dialogic.signal_event.connect(DialogicSignal)
	if DialogueTracker.tanuki_met != NONE:
		blem.queue_free()

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)


func _on_dialogue_barrier_body_entered(body: Node2D) -> void:
	if body is Player and DialogueTracker.tanuki_met == NONE:
		PlayerPause.playerPaused = true
		Dialogic.start("tanuki_saving_dialogue")
		

func DialogicSignal(arg: String):
	if arg == "tanuki_meet_exit":
		PlayerPause.playerPaused = false
		DialogueTracker.tanuki_met = MET


func _on_door_h_body_entered(body: Node2D) -> void:
	if body is Player:
		house1_open.visible = true
		print("hello")
