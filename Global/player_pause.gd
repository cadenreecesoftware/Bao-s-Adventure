extends Node
signal paused_changed(value)
var playerPaused = false:
	get:
		return playerPaused
	set(value):
			playerPaused = value
			emit_signal("paused_changed", playerPaused)
