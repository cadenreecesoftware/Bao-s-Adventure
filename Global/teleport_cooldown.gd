extends Timer
@onready var timer = $"/root/TeleportCooldown"



func _on_timeout() -> void:
	timer.stop()
	PlayerPause.playerPaused = false
	
