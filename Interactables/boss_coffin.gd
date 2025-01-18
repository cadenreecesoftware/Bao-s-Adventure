extends CharacterBody2D

var player_in_area = false
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)


func _physics_process(delta: float) -> void:
	if player_in_area and DialogueTracker.temple_boss_progress == NONE:
		$Sprite2D.material.set_shader_parameter("line_thickness", 1)
		if Input.is_action_just_pressed("interact") and PlayerPause.playerPaused != true:
			$AnimationPlayer.play("Open")
			Dialogic.start("opening_boss_dialogue")
			PlayerPause.playerPaused = true
			
	else:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
				
			

func DialogicSignal(arg: String):
	if arg == "exit_boss_dialogue":
		PlayerPause.playerPaused = false
		DialogueTracker.temple_boss_progress = MET




func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false
