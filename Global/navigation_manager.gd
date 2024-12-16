extends Node


const scene_level1 = preload("res://Levels/level.tscn")
const scene_level2 = preload("res://Levels/level_2.tscn")

signal on_trigger_player_spawn

var spawn_door_tag
var scene_to_load

func go_to_level(level_tag, destination_tag):
	
	match level_tag:
		"level":
			scene_to_load = scene_level1
		"level_2":
			scene_to_load = scene_level2
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		#get_tree().change_scene_to_packed(scene_to_load)
		get_tree().change_scene_to_packed.bind(scene_to_load).call_deferred()
		#changeScener(scene_to_load).call_deferred()

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
#func changeScener(scene):
	#get_tree().change_scene_to_packed(scene)
