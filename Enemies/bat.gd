extends CharacterBody2D



func _physics_process(delta) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	move_and_slide()


func _on_hurtbox_area_entered(area):
	var direction = (position - area.owner.position).normalized()
	velocity = direction * 85
