extends CharacterBody2D

var player_in_area = false
var dialogue_cooldown = false
@onready var timer = $Timer
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}



func _physics_process(delta: float) -> void:
	if player_in_area:
		$Sprite2D.material.set_shader_parameter("line_thickness", 1)
		if Input.is_action_just_pressed("interact") and PlayerPause.playerPaused != true and Wallet.wallet >= 25:
			PlayerStats.max_health += 1
			PlayerStats.health = PlayerStats.max_health
			DialogueTracker.rocco_progress = QUESTING
			queue_free()
	else:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
			
			


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false


func _on_timer_timeout() -> void:
	dialogue_cooldown = false
