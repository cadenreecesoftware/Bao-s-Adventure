class_name SavedGame
extends Resource
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}

@export var player_position:Vector2
@export var player_health: float
@export var player_max_health: float
@export var current_level: String
@export var dialogue_saver: Array
@export var player_wallet: float
@export var player_sword_damage: float
