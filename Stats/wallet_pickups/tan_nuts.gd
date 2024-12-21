extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player and Wallet.wallet != Wallet.max_wallet:
		NutPickupNoise.play_noise()
		Wallet.wallet += 1
		queue_free()
	elif body is Player and Wallet.max_wallet == Wallet.max_wallet:
		NutPickupNoise.play_noise()
		queue_free()
