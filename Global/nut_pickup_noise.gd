extends AudioStreamPlayer

const noise = preload("res://Art/Action RPG Resources/Music and Sounds/collect_nuts.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	stream = music
	volume_db = volume
	play()
	
	
func play_noise():
	_play_music(noise, -5)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
