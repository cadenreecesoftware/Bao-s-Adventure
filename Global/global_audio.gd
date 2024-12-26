extends AudioStreamPlayer
signal volume_changed(value)
const forest_music1 = preload("res://Music/MysticalForest1.mp3")
const town_music = preload("res://Music/Mill Town.mp3")
const interior_music = preload("res://Music/Rory's Shop.mp3")

var current_music = ""
var volume: int = -20
	#set(value): 
		#volume = value
		#emit_signal("volume_changed", volume)
	#get: return volume

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_forest_music_level():
	current_music = "forest_music1"
	forest_music1.loop
	_play_music(forest_music1, volume)
func play_town_music():
	current_music = "town_music"
	town_music.loop
	_play_music(town_music, volume)
func play_interior_music():
	current_music = "interior_music"
	interior_music.loop
	_play_music(interior_music, volume)
	
