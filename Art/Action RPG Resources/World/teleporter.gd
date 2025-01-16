extends Area2D
@onready var active_sprite = $Sprite2D2
@onready var base_sprite = $Sprite2D
@onready var tp_wait = $Timer
@onready var audio = $AudioStreamPlayer
func _on_body_entered(body: Node2D) -> void:
	if body is Player and TeleportCooldown.is_stopped():
		tp_wait.start(0.5)
		PlayerPause.playerPaused = true
		audio.play()
		await tp_wait.timeout
		body.set_position($Marker2D.global_position)
		TeleportCooldown.start(0.2)
	active_sprite.visible = true
		

		
# use global timer
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		base_sprite.visible = true
		active_sprite.visible = false


func _on_timer_timeout() -> void:
	tp_wait.stop()
