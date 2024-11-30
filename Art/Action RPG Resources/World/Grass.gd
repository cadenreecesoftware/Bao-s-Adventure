extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame
func create_grass_effect():
	#loads our grass effect SCENE
		var grass_effect = load("res://Art/Action RPG Resources/Effects/grass_effect.tscn")
		#this creates an INSTANCE of the SCENE ^^^
		var grassEffect = grass_effect.instantiate()
		#gets our root of our main scene in this case "level"
		var world = get_tree().current_scene
		world.add_child(grassEffect)
		grassEffect.global_position = global_position


func _on_hurtbox_area_entered(_area) -> void:
	create_grass_effect()
	queue_free()
