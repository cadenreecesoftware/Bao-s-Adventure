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
var tanuki_met = NONE:
	get:
		return tanuki_met
	set(value):
		tanuki_met = value
		
var tanuki_progress = NONE:
	get:
		return tanuki_progress
	set(value):
		tanuki_progress = value
var key_progress = NONE:
	get:
		return key_progress
	set(value):
		key_progress = value
