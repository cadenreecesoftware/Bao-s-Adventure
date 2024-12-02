extends CharacterBody2D

const EnemyDeathEffect = preload("res://Enemies/enemy_death_effect.tscn")
@export var ACCELERATION = 280
@export var MAX_SPEED = 30
@export var FRICTION = 200
enum {
	IDLE,
	WANDER,
	CHASE
}

@onready var stats = $Hurtbox/Stats
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var sprite = $AnimatedSprite
var state = CHASE



func _physics_process(delta) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
			
	move_and_slide()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	var direction = (position - area.owner.position).normalized()
	velocity = direction * 85


func _on_stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
