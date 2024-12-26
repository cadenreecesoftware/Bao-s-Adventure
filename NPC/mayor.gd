extends CharacterBody2D


var mayor_dialogue = preload("res://Dialogue/Timelines/MayorMeeting.dtl")
var player_in_area = false
var dialogue_cooldown = false
@onready var timer = $Timer


func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	
func _physics_process(delta: float) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("interact") and PlayerPause.playerPaused != true and dialogue_cooldown == false:
			run_dialogue("MayorMeeting")
			PlayerPause.playerPaused = true

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false

func run_dialogue(dialogue_string: String):
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg: String):
	if arg == "exit_mayor":
		timer.start(1)
		dialogue_cooldown = true
		PlayerPause.playerPaused = false

func _on_timer_timeout() -> void:
	dialogue_cooldown = false
