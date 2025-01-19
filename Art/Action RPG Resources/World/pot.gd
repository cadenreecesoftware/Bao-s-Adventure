extends Node2D

const pot_effect = preload("res://Art/Action RPG Resources/Effects/pot_effect.tscn")
const HeartDrop = preload("res://Stats/heartpickups/heart_drop.tscn")
const TanNutDrop = preload("res://Stats/wallet_pickups/tan_nuts.tscn")



const dropRate = [0,0,1,1,1,1,1,1,1,2,2]
# Called every frame. 'delta' is the elapsed time since the previous frame
func create_pot_effect():
	#loads our grass effect SCENE
		
		#this creates an INSTANCE of the SCENE ^^^
		var potEffect = pot_effect.instantiate()
		get_parent().add_child(potEffect)
		potEffect.global_position = global_position


func _on_hurtbox_area_entered(_area) -> void:
	create_pot_effect()
	match dropRate.pick_random():
		1:
			var heartDrop = HeartDrop.instantiate()
			#get_parent().add_child(heartDrop)
			get_parent().call_deferred("add_child", heartDrop)
			heartDrop.global_position = global_position
		2:
			var tanNutDrop = TanNutDrop.instantiate()
			get_parent().call_deferred("add_child", tanNutDrop)
			tanNutDrop.global_position = global_position
		0:
			pass
	queue_free()
