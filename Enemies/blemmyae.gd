extends CharacterBody2D
const EnemyDeathEffect = preload("res://Enemies/enemy_death_effect.tscn")
const HeartDrop = preload("res://Stats/heartpickups/heart_drop.tscn")
const TanNutDrop = preload("res://Stats/wallet_pickups/tan_nuts.tscn")

@onready var ray_cast = $RayCast2D
@onready var navigation_cast_1 = $RaycastHolder/RayCast2D
@onready var navigation_cast_2 = $RaycastHolder/RayCast2D2
@onready var navigation_cast_3 = $RaycastHolder/RayCast2D3
@onready var navigation_cast_4 = $RaycastHolder/RayCast2D4
@onready var navigation_cast_5 = $RaycastHolder/RayCast2D5
@onready var navigation_cast_6 = $RaycastHolder/RayCast2D6
@onready var navigation_cast_7 = $RaycastHolder/RayCast2D7
@onready var navigation_cast_8 = $RaycastHolder/RayCast2D8
@onready var timer = $Timer
@onready var dir_cooldown = $Timer2
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
var casts_hitting = []
#var casts_missing = [navigation_cast_1, navigation_cast_2, navigation_cast_3, navigation_cast_4, navigation_cast_5
#, navigation_cast_6, navigation_cast_7, navigation_cast_8]
var casts_missing = []
var hitting_wall = false
var escape_dir

func _ready():
	randomize()
	casts_missing.append(navigation_cast_1)
	casts_missing.append(navigation_cast_2)
	casts_missing.append(navigation_cast_3)
	casts_missing.append(navigation_cast_4)
	casts_missing.append(navigation_cast_5)
	casts_missing.append(navigation_cast_6)
	casts_missing.append(navigation_cast_7)
	casts_missing.append(navigation_cast_8)
	player = get_parent().get_node("PlayerPanda")
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	navigation_cast_hitting()
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
			animationTree.set("parameters/Attack/blend_position", to_local(player.position))
			animationState.travel("Attack")
		TOOCLOSE:
			timer.stop()
			animationTree.set("parameters/Run/blend_position", velocity)
			animationState.travel("Run")
			var direction = - global_position.direction_to(player.global_position)
			if(!casts_hitting.is_empty() and dir_cooldown.is_stopped()):
				escape_dir = casts_missing.pick_random()
				velocity =  velocity.move_toward(escape_dir.target_position * MAX_SPEED, ACCELERATION * delta)
				dir_cooldown.start(1)
			#elif:(casts_hitting.is_empty()):
			#elif(timer.is_stopped()):
			if (!casts_hitting.is_empty() and !dir_cooldown.is_stopped()):
				velocity =  velocity.move_toward(escape_dir.target_position * MAX_SPEED, ACCELERATION * delta)
				#if(dir_cooldown.is_stopped):
					#dir_cooldown.start()
			elif(casts_hitting.is_empty()):
				dir_cooldown.stop()
				velocity =  velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			if (velocity == Vector2.ZERO):
				escape_dir = casts_missing.pick_random()
				velocity =  velocity.move_toward(escape_dir.target_position * MAX_SPEED, ACCELERATION * delta)
			

			#else:
				#var escape_dir = casts_missing.pick_random()
				#velocity =  velocity.move_toward(escape_dir.target_position * MAX_SPEED, ACCELERATION * delta)

			
	
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



func navigation_cast_hitting():
	if(navigation_cast_1.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_1)):
			casts_hitting.append(navigation_cast_1)
			casts_missing.erase(navigation_cast_1)
	elif(!navigation_cast_1.is_colliding()):
		if(!casts_missing.has(navigation_cast_1)):
			casts_missing.append(navigation_cast_1)
			casts_hitting.erase(navigation_cast_1)
	if(navigation_cast_2.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_2)):
			casts_hitting.append(navigation_cast_2)
			casts_missing.erase(navigation_cast_2)
	elif(!navigation_cast_2.is_colliding()):
		if(!casts_missing.has(navigation_cast_2)):
			casts_missing.append(navigation_cast_2)
			casts_hitting.erase(navigation_cast_2)
	if(navigation_cast_3.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_3)):
			casts_hitting.append(navigation_cast_3)
			casts_missing.erase(navigation_cast_3)
	elif(!navigation_cast_3.is_colliding()):
		if(!casts_missing.has(navigation_cast_3)):
			casts_missing.append(navigation_cast_3)
			casts_hitting.erase(navigation_cast_3)
	if(navigation_cast_4.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_4)):
			casts_hitting.append(navigation_cast_4)
			casts_missing.erase(navigation_cast_4)
	elif(!navigation_cast_4.is_colliding()):
		if(!casts_missing.has(navigation_cast_4)):
			casts_missing.append(navigation_cast_4)
			casts_hitting.erase(navigation_cast_4)
	if(navigation_cast_5.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_5)):
			casts_hitting.append(navigation_cast_5)
			casts_missing.erase(navigation_cast_5)
	elif(!navigation_cast_5.is_colliding()):
		if(!casts_missing.has(navigation_cast_5)):
			casts_missing.append(navigation_cast_5)
			casts_hitting.erase(navigation_cast_5)
	if(navigation_cast_6.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_6)):
			casts_hitting.append(navigation_cast_6)
			casts_missing.erase(navigation_cast_6)
	elif(!navigation_cast_6.is_colliding()):
		if(!casts_missing.has(navigation_cast_6)):
			casts_missing.append(navigation_cast_6)
			casts_hitting.erase(navigation_cast_6)
	if(navigation_cast_7.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_7)):
			casts_hitting.append(navigation_cast_7)
			casts_missing.erase(navigation_cast_7)
	elif(!navigation_cast_7.is_colliding()):
		if(!casts_missing.has(navigation_cast_7)):
			casts_missing.append(navigation_cast_7)
			casts_hitting.erase(navigation_cast_7)
	if(navigation_cast_8.is_colliding()):
		hitting_wall = true
		if(!casts_hitting.has(navigation_cast_8)):
			casts_hitting.append(navigation_cast_8)
			casts_missing.erase(navigation_cast_8)
	elif(!navigation_cast_8.is_colliding()):
		if(!casts_missing.has(navigation_cast_8)):
			casts_missing.append(navigation_cast_1)
			casts_hitting.erase(navigation_cast_1)

#func navigation_cast_missing():
	#if(!navigation_cast_1.is_colliding()):
		#casts_missing.append(navigation_cast_1)
		#casts_hitting.erase(navigation_cast_1)
	#if(!navigation_cast_2.is_colliding()):
		#casts_missing.append(navigation_cast_2)
		#casts_hitting.erase(navigation_cast_2)
	#if(!navigation_cast_3.is_colliding()):
		#casts_missing.append(navigation_cast_3)
		#casts_hitting.erase(navigation_cast_3)
	#if(!navigation_cast_4.is_colliding()):
		#casts_missing.append(navigation_cast_4)
		#casts_hitting.erase(navigation_cast_4)
	#if(!navigation_cast_5.is_colliding()):
		#casts_missing.append(navigation_cast_5)
		#casts_hitting.erase(navigation_cast_5)
	#if(!navigation_cast_6.is_colliding()):
		#casts_missing.append(navigation_cast_6)
		#casts_hitting.erase(navigation_cast_6)
	#if(!navigation_cast_7.is_colliding()):
		#casts_missing.append(navigation_cast_7)
		#casts_hitting.erase(navigation_cast_7)
	#if(!navigation_cast_1.is_colliding()):
		#casts_missing.append(navigation_cast_8)
		#casts_hitting.erase(navigation_cast_8)
	


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


#func _on_wall_detector_body_entered(body: Node2D) -> void:
	#navigation_cast_hitting()


#
#func _on_wall_detector_body_exited(body: Node2D) -> void:
	#navigation_cast_missing()
