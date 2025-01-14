extends CharacterBody2D

const EnemyDeathEffect = preload("res://Enemies/enemy_death_effect.tscn")
const HeartDrop = preload("res://Stats/heartpickups/heart_drop.tscn")
const TanNutDrop = preload("res://Stats/wallet_pickups/tan_nuts.tscn")

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
@onready var hurtbox = $Hurtbox
@onready var softCollision = $SoftCollision
@onready var wanderController = $WanderController
@onready var animationPlayer = $AnimationPlayer


var state = CHASE
const randomStates = [IDLE, WANDER]
#array for heart drop rate, 0 is no don't drop, 1 is do drop
const dropRate = [0,0,0,0,2,2,1]

func _ready():
	state = pick_random_state(randomStates)

func _physics_process(delta) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
		
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
			
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				accelerate_towards_point(wanderController.target_position, delta)
			#accelerate_towards_point(wanderController.target_position, delta)
			accelerate_towards_point(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= MAX_SPEED * delta:
				update_wander()
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	move_and_slide()
	
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0



func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	
func update_wander():
	state = pick_random_state(randomStates)
	wanderController.start_wander_timer(randi_range(1,3))
#func state_switcher():
	

func pick_random_state(state_list):
	return state_list.pick_random()
	
func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	var direction = (position - area.owner.position).normalized()
	animationPlayer.play("hit_flash_animation")
	hurtbox.create_hit_effect()
	velocity = direction * 105



func _on_stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	#add elif dropRate.pick_random() == a different number for a currency
	#if dropRate.pick_random() == 1:
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



func _on_hitbox_area_entered(area: Area2D) -> void:
	var direction = (position - area.owner.position).normalized()
	velocity = direction * 105
