extends Node
enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}
var mayor_progress = NONE:
	get:
		return mayor_progress
	set(value):
		mayor_progress = value

var well_progress = NONE:
	get:
		return well_progress
	set(value):
		well_progress = value

var darpie_progress = NONE:
	get:
		return darpie_progress
	set(value):
		darpie_progress = value
	
var guard_progress = NONE:
	get:
		return guard_progress
	set(value):
		guard_progress = value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
