extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_forest_music_level()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("pause"):
		#pauseMenu()
		#
#func pauseMenu():
	#if paused:
		#pause_menu.hide()
		#get_tree().paused = false
	#else:
		#pause_menu.show()
		#get_tree().paused = true
	#
	#paused = !paused

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
