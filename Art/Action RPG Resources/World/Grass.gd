extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("attack"):
		#loads our grass effect SCENE
		var grass_effect = preload("res://Art/Action RPG Resources/Effects/grass_effect.tscn")
		#this creates an INSTANCE of the SCENE ^^^
		var grassEffect = grass_effect.instantiate()
		#gets our root of our main scene in this case "level"
		var world = get_tree().current_scene
		world.add_child(grassEffect)
		grassEffect.global_position = global_position
		queue_free()
