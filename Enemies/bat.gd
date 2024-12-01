extends CharacterBody2D

@onready var stats = $Hurtbox/Stats


func _physics_process(delta) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	move_and_slide()


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	var direction = (position - area.owner.position).normalized()
	velocity = direction * 85


func _on_stats_no_health() -> void:
	queue_free()
