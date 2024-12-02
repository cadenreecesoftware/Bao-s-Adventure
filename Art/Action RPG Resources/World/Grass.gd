extends Node2D

const grass_effect = preload("res://Art/Action RPG Resources/Effects/grass_effect.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame
func create_grass_effect():
	#loads our grass effect SCENE
		
		#this creates an INSTANCE of the SCENE ^^^
		var grassEffect = grass_effect.instantiate()
		get_parent().add_child(grassEffect)
		grassEffect.global_position = global_position


func _on_hurtbox_area_entered(_area) -> void:
	create_grass_effect()
	queue_free()
