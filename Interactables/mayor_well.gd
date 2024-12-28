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

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)


func _physics_process(delta: float) -> void:
	if player_in_area:
		$Sprite2D.material.set_shader_parameter("line_thickness", 1)
		if Input.is_action_just_pressed("interact") and PlayerPause.playerPaused != true and dialogue_cooldown == false:
			match DialogueTracker.well_progress:
				NONE:
					Dialogic.start("well_timeline")
					PlayerPause.playerPaused = true
					DialogueTracker.well_progress = MET
				MET:
					NavigationManager.go_to_level("scene_well", "S")
	else:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
				
			

func DialogicSignal(arg: String):
	if arg == "exit_well_timeline":
		timer.start(0.5)
		dialogue_cooldown = true
		PlayerPause.playerPaused = false


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false


func _on_timer_timeout() -> void:
	dialogue_cooldown = false
