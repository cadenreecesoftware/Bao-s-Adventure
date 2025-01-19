extends Node


const scene_level1 = preload("res://Levels/level.tscn")
const scene_level2 = preload("res://Levels/level_2.tscn")
const scene_town = preload("res://Levels/town.tscn")
const scene_house_1_inter = preload("res://Levels/house_1_inter.tscn")
const scene_house_2_inter = preload("res://Levels/house_2_inter.tscn")
const scene_house_3_inter = preload("res://Levels/house_3_inter.tscn")
const scene_house_4_inter = preload("res://Levels/house_4_inter.tscn")
const scene_house_5_inter = preload("res://Levels/house_5_inter.tscn")
const scene_house_6_inter = preload("res://Levels/house_6_inter.tscn")
const scene_house_7_inter = preload("res://Levels/house_7_inter.tscn")
const scene_well = preload("res://Levels/well.tscn")
const scene_roost_inter = preload("res://Levels/roost_interior.tscn")
const scene_level3 = preload("res://Levels/level_3.tscn")
const scene_level4 = preload("res://Levels/level_4.tscn")
const scene_forest_house_inter = preload("res://Levels/forest_house_inter.tscn")
const scene_temple_entrance = preload("res://Levels/temple_entrance.tscn")
const scene_temple_room_1 = preload("res://Levels/temple_room_1.tscn")
const scene_temple_room_2 = preload("res://Levels/temple_room_2.tscn")
const scene_temple_room_3 = preload("res://Levels/temple_room_3.tscn")
const scene_temple_room_4 = preload("res://Levels/temple_room_4.tscn")
const scene_temple_room_5 = preload("res://Levels/temple_room_5.tscn")
const scene_temple_boss_room = preload("res://Levels/temple_boss_room.tscn")



signal on_trigger_player_spawn

var spawn_door_tag = null:
	get:
		return spawn_door_tag
	set(value):
		spawn_door_tag = value
var scene_to_load
var current_level: String = "":
	get:
		return current_level
	set(value):
		current_level = value

func go_to_level(level_tag, destination_tag):
	
	match level_tag:
		"level":
			scene_to_load = scene_level1
		"level_2":
			scene_to_load = scene_level2
		"town":
			scene_to_load = scene_town
		"house_1_inter":
			scene_to_load = scene_house_1_inter
		"house_2_inter":
			scene_to_load = scene_house_2_inter
		"house_3_inter":
			scene_to_load = scene_house_3_inter
		"house_4_inter":
			scene_to_load = scene_house_4_inter
		"house_5_inter":
			scene_to_load = scene_house_5_inter
		"house_6_inter":
			scene_to_load = scene_house_6_inter
		"house_7_inter":
			scene_to_load = scene_house_7_inter
		"scene_well":
			scene_to_load = scene_well
		"roost_interior":
			scene_to_load = scene_roost_inter
		"level_3":
			scene_to_load = scene_level3
		"level_4":
			scene_to_load = scene_level4
		"forest_house_inter":
			scene_to_load = scene_forest_house_inter
		"temple_entrance":
			scene_to_load = scene_temple_entrance
		"temple_room_1":
			scene_to_load = scene_temple_room_1
		"temple_room_2":
			scene_to_load = scene_temple_room_2
		"temple_room_3":
			scene_to_load = scene_temple_room_3
		"temple_room_4":
			scene_to_load = scene_temple_room_4
		"temple_room_5":
			scene_to_load = scene_temple_room_5
		"temple_boss_room":
			scene_to_load = scene_temple_boss_room
		
			
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		#get_tree().change_scene_to_packed(scene_to_load)
		get_tree().change_scene_to_packed.bind(scene_to_load).call_deferred()
		#changeScener(scene_to_load).call_deferred()

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
#func changeScener(scene):
	#get_tree().change_scene_to_packed(scene)
