extends Node2D

const grass_effect = preload("res://Art/Action RPG Resources/Effects/grass_effect.tscn")
const HeartDrop = preload("res://Stats/heartpickups/heart_drop.tscn")


const dropRate = [0,0,0,0,0,0,0,0,0,1]
# Called every frame. 'delta' is the elapsed time since the previous frame
func create_grass_effect():
	#loads our grass effect SCENE
		
		#this creates an INSTANCE of the SCENE ^^^
		var grassEffect = grass_effect.instantiate()
		get_parent().add_child(grassEffect)
		grassEffect.global_position = global_position


func _on_hurtbox_area_entered(_area) -> void:
	create_grass_effect()
	if dropRate.pick_random() == 1:
		var heartDrop = HeartDrop.instantiate()
		get_parent().call_deferred("add_child", heartDrop)
		heartDrop.global_position = global_position
	queue_free()
