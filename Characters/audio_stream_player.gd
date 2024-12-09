extends AudioStreamPlayer

func _ready(from_position=0.0):
	randomize()
	pitch_scale = randf_range(0.8 , 1.1) 
	
	play(from_position)
