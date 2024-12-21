extends Node
signal wallet_changed(value)
signal max_wallet_changed(value)
signal max_wallet_hit
@export var max_wallet = 300:
	get:
		return max_wallet
	set(value):
		max_wallet = value
		self.wallet = min(0, max_wallet)
		emit_signal("max_wallet_changed", max_wallet)
var wallet = 0:
	get: 
		return wallet
	set(value): 
		wallet = value
		emit_signal("wallet_changed", wallet)
		if wallet == max_wallet:
			emit_signal("max_wallet_hit")
func _ready():
	self.wallet = 0
