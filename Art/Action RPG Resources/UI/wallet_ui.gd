extends Control

@onready var wallet_counter = $Label
var nuts = Wallet.wallet:
	get = get_nuts, set = set_nuts
	
func get_nuts():
	return nuts

func set_nuts(value):
		nuts = clamp(value, 0, Wallet.max_wallet)
		if nuts < 100:
			wallet_counter.text = "0" + str(nuts)
		else:
			wallet_counter.text = str(nuts)
	
var max_nuts = Wallet.max_wallet:
	get = get_max_nuts, set = set_max_nuts
func get_max_nuts():
	return max_nuts
func set_max_nuts(value):
		max_nuts = max(value, 1)

func _ready():
	self.max_nuts = Wallet.max_wallet
	self.nuts = Wallet.wallet
	Wallet.connect("wallet_changed", set_nuts)
	Wallet.connect("max_wallet_changed", set_max_nuts)
