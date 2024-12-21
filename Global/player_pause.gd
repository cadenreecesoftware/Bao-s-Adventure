extends Node
signal paused_changed(value)
var playerPaused = false:
	get:
		return playerPaused
	set(value):
			playerPaused = value
			emit_signal("paused_changed", playerPaused)
			print(playerPaused)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
