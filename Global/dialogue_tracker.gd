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
#manages chest in the first room to the left in the forest temple
var grapple_chest = NONE:
	get:
		return grapple_chest
	set(value):
		grapple_chest = value
var whetstone_progress = NONE:
	get:
		return whetstone_progress
	set(value):
		whetstone_progress = value
var temple_nuts_chest_progress = NONE:
	get:
		return temple_nuts_chest_progress
	set(value):
		temple_nuts_chest_progress = value
var temple_boss_progress = NONE:
	get:
		return temple_boss_progress
	set(value):
		temple_boss_progress = value
var doe_progress = NONE:
	get:
		return doe_progress
	set(value):
		doe_progress = value
var fen_progress = NONE:
	get:
		return fen_progress
	set(value):
		fen_progress = value
var tink_progress = NONE:
	get:
		return tink_progress
	set(value):
		tink_progress = value
var mrbrie_progress = NONE:
	get:
		return mrbrie_progress
	set(value):
		mrbrie_progress = value
var msbrie_progress = NONE:
	get:
		return msbrie_progress
	set(value):
		msbrie_progress = value
var weaver_progress = NONE:
	get:
		return weaver_progress
	set(value):
		weaver_progress = value
var sadie_progress = NONE:
	get:
		return sadie_progress
	set(value):
		sadie_progress = value
var rocco_progress = NONE:
	get:
		return rocco_progress
	set(value):
		rocco_progress = value
