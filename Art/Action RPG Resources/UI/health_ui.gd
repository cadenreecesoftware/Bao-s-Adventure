extends Control

@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty
var hearts = 4:
	get = get_hearts, set = set_hearts
	
func get_hearts():
	return hearts

func set_hearts(value):
		hearts = clamp(value, 0, max_hearts)
		if heartUIFull != null:
			heartUIFull.size.x = hearts * 16
	
var max_hearts = 4: 
	get = get_max_hearts, set = set_max_hearts
func get_max_hearts():
	return max_hearts
func set_max_hearts(value):
		max_hearts = max(value, 1)
		if heartUIEmpty != null:
			heartUIEmpty.size.x = max_hearts * 16

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", set_hearts)
	print("whaaat")
	PlayerStats.connect("max_health_changed", set_max_hearts)
