extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(DialogicSignal)
	Dialogic.start("credits")
	GlobalAudio.stop()


func DialogicSignal(arg: String):
	if arg == "exit_credits":
		PlayerPause.playerPaused = false
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file.call_deferred("res://Levels/main_menu.tscn")
