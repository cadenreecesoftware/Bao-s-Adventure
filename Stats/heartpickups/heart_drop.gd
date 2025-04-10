extends Area2D





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#add sound effect
func _on_body_entered(body: Node2D) -> void:
	if body is Player and PlayerStats.health != PlayerStats.max_health:
		HeartPickupNoise.play_noise()
		PlayerStats.health += 1
		queue_free()
	elif body is Player and PlayerStats.health == PlayerStats.max_health:
		HeartPickupNoise.play_noise()
		queue_free()
		
	
