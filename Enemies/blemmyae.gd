extends CharacterBody2D
const EnemyDeathEffect = preload("res://Enemies/enemy_death_effect.tscn")
const HeartDrop = preload("res://Stats/heartpickups/heart_drop.tscn")
const TanNutDrop = preload("res://Stats/wallet_pickups/tan_nuts.tscn")

@onready var ray_cast = $RayCast2D
@onready var timer = $Timer
@onready var stats = $Hurtbox/Stats
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var hurtbox = $Hurtbox
@onready var hitFlashPlayer = $hit_flash_player
@onready var animationState = animationTree.get("parameters/playback")
@export var ammo : PackedScene
@export var ACCELERATION = 280
@export var MAX_SPEED = 30
@export var FRICTION = 200

enum {
	IDLE,
	INRANGE,
	TOOCLOSE
}
var player
var state = IDLE
const dropRate = [0,0,0,1,1,1,2]

func _ready():
	player = get_parent().get_node("PlayerPanda")
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			timer.stop()
			animationTree.set("parameters/Idle/blend_position", to_local(player.position))
			#animationTree.set("parameters/Run/blend_position", velocity)
			#animationTree.set("parameters/Attack/blend_position", to_local(player.position))
			animationState.travel("Idle")

		INRANGE:
			_aim()
			_check_player_collision()
			#velocity = Vector2.ZERO
			#animationTree.set("parameters/Idle/blend_position", velocity)
			#animationTree.set("parameters/Run/blend_position", velocity)
			animationTree.set("parameters/Attack/blend_position", to_local(player.position))
			animationState.travel("Attack")
		TOOCLOSE:
			timer.stop()
			#animationTree.set("parameters/Idle/blend_position", velocity)
			animationTree.set("parameters/Run/blend_position", velocity)
			#animationTree.set("parameters/Attack/blend_position", to_local(player.position))
			animationState.travel("Run")
			var direction = - global_position.direction_to(player.global_position)
			velocity =  velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			
	
func _aim():
	ray_cast.target_position = to_local(player.position)
func _check_player_collision():
	if ray_cast.get_collider() == player and timer.is_stopped():
		timer.start()
	elif ray_cast.get_collider() != player and not timer.is_stopped():
		timer.stop()


func _on_timer_timeout() -> void:
	_shoot()

func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(bullet)


func _on_player_detection_zone_body_entered(body: Node2D) -> void:
	state = INRANGE


func _on_player_detection_zone_body_exited(body: Node2D) -> void:
	state = IDLE


func _on_player_too_close_zone_body_entered(body: Node2D) -> void:
	state = TOOCLOSE


func _on_player_too_close_zone_body_exited(body: Node2D) -> void:
	state = INRANGE


func _on_stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
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


func _on_hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	var direction = (position - area.owner.position).normalized()
	#knockback, modify the int for bigger or smaller knockback
	velocity = direction * 140
	hitFlashPlayer.play("hit_flash")
	#make the slimes hit effect slimey
	hurtbox.create_hit_effect()
