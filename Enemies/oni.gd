extends CharacterBody2D

const EnemyDeathEffect = preload("res://Enemies/enemy_death_effect.tscn")

enum {
	NONE,
	MET, 
	QUESTING,
	DONE
}
enum {
	INRANGE,
	CHASE
}

@export var ACCELERATION = 280
@export var MAX_SPEED = 30
@export var FRICTION = 200

@onready var stats = $Hurtbox/Stats
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var hurtbox = $Hurtbox
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var laugh_cooldown = $Timer

var state = CHASE


func _ready() -> void:
	laugh_cooldown.start(randi_range(15,30))

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)	
	move_and_slide()
	if PlayerStats.health == 0:
		queue_free()
	match state:
		INRANGE:
			var player = playerDetectionZone.player
			if(PlayerStats.health > 0):
				animationTree.set("parameters/Attack/blend_position", to_local(player.position))
				animationState.travel("Attack")
			else:
				pass

		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				animationTree.set("parameters/Idle/blend_position", velocity)
				animationTree.set("parameters/Move/blend_position", velocity)
				animationState.travel("Move")
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			
#func seek_player():
	#if playerDetectionZone.can_see_player():
		#state = CHASE

func in_range_seek():
	if !$InRangeZone.can_see_player():
		state = CHASE


func _on_in_range_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		state = INRANGE


#func _on_in_range_zone_body_exited(body: Node2D) -> void:
	#if body is Player and attack_cooldown.is_stopped():
		#state = CHASE


func _on_hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	var direction = (position - area.owner.position).normalized()
	#knockback, modify the int for bigger or smaller knockback
	velocity = direction * 65
	$HitFlashPlayer.play("hit_flash")
	hurtbox.create_hit_effect()


func _on_timer_timeout() -> void:
	laugh_cooldown.start(randi_range(15,30))
	$LaughPlayer.play()
	


func _on_stats_no_health() -> void:
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	DialogueTracker.temple_boss_progress = DONE
	queue_free()
	Dialogic.start("boss_beat")
