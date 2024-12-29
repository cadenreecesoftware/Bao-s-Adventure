extends CharacterBody2D
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}
var player_in_area = false
var dialogue_cooldown = false

@onready var timer = $Timer

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	
	
func _physics_process(delta: float) -> void:
	if player_in_area:
		$AnimatedSprite2D.material.set_shader_parameter("line_thickness", 1)
		if Input.is_action_just_pressed("interact") and PlayerPause.playerPaused != true and dialogue_cooldown == false:
			match DialogueTracker.darpie_progress:
				NONE:
					Dialogic.start("DarpieMeeting")
					PlayerPause.playerPaused = true
					DialogueTracker.darpie_progress = MET
				MET:
					Dialogic.start("darpie_met")
					PlayerPause.playerPaused = true
	else:
		$AnimatedSprite2D.material.set_shader_parameter("line_thickness", 0)



func DialogicSignal(arg: String):
	if arg == "exit_darpie":
		timer.start(0.5)
		dialogue_cooldown = true
		PlayerPause.playerPaused = false


func _on_timer_timeout() -> void:
	dialogue_cooldown = false


#func _on_chat_detection_body_entered(body: Node2D) -> void:
	#if body is Player:
		#player_in_area = true
#
#func _on_chat_detection_body_exited(body: Node2D) -> void:
	#if body is Player:
		#player_in_area = false


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false
