extends Area2D

@onready var timer = $Timer



	#if DialogueManager.dialogue_ended:
		#queue_free()
		#PlayerPause.playerPaused = false
	#await get_tree().create_timer(1).timeout
