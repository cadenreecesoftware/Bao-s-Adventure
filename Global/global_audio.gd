extends AudioStreamPlayer

const forest_music1 = preload("res://Music/MysticalForest1.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_forest_music_level():
	forest_music1.loop
	_play_music(forest_music1, -20)
