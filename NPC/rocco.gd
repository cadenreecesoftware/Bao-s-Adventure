extends CharacterBody2D

enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}

var player_in_area = false
var dialogue_cooldown = false
#var mayor_progress = DialogueTracker.mayor_progress


@onready var timer = $Timer


func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	
func _physics_process(delta: float) -> void:
	if player_in_area:
		$AnimatedSprite2D.material.set_shader_parameter("line_thickness", 1)
		if Input.is_action_just_pressed("interact") and PlayerPause.playerPaused != true and dialogue_cooldown == false:
			match DialogueTracker.rocco_progress:
				NONE:
					run_dialogue("rocco_meeting")
					PlayerPause.playerPaused = true
					DialogueTracker.rocco_progress = MET
				MET:
					run_dialogue("rocco_met")
					PlayerPause.playerPaused = true
				QUESTING:
					run_dialogue("rocco_bought")
					PlayerPause.playerPaused = true
	else:
		$AnimatedSprite2D.material.set_shader_parameter("line_thickness", 0)

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false

func run_dialogue(dialogue_string: String):
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg: String):
	if arg == "exit_rocco":
		timer.start(0.5)
		dialogue_cooldown = true
		PlayerPause.playerPaused = false

func _on_timer_timeout() -> void:
	dialogue_cooldown = false
