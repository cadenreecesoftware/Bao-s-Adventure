extends CharacterBody2D

class_name Player

enum {
	MOVE,
	ROLL,
	ATTACK,
	GRAPPLE
}

var state = MOVE
var roll_vector = Vector2.LEFT
var input_vector = Vector2.ZERO
var stats = PlayerStats
#var grapple_tip = preload("res://Characters/chain_head.tscn")
#var grapple_instanced = false
#var grapple_tip_instance = grapple_tip.instantiate()



@export var move_speed : float = 75
@export var roll_speed : float = 1.5
#@export var starting_direction : Vector2= Vector2(0,1)
@onready var animations = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var hurtbox = $Hurtbox
@onready var animationState = animationTree.get("parameters/playback")
@onready var hit_flash_anim_player = $HitFlashAnimationPlayer
@onready var grapple = $"grap_pivot/grapple"
@onready var player_collider = $CollisionShape2D
@onready var grapple_pivot = $grap_pivot






#parameters/Walk/blend_position


func _ready():
	randomize()
	self.stats.connect("no_health", queue_free)
	animationTree.active = true
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)

func _on_spawn(position: Vector2, direction: String):
	animations.play("Idle" + direction.to_pascal_case())
	global_position = position
	

func _physics_process(_delta):
	match state:
		MOVE: 
			move_state()
		ROLL:
			roll_state()
		ATTACK:
			attack_state()
		GRAPPLE:
			grapple_state()
			
	

func move_state():
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	move()
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationTree.set("parameters/Grapple/blend_position", input_vector)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	if Input.is_action_just_pressed("grapple"):
		state = GRAPPLE
	
func roll_state():
	input_vector = roll_vector * roll_speed
	animationState.travel("Roll")
	#make the player have i-frames during their dodge
	hurtbox.start_invincibility(0.5)
	move()

func _draw():
	if grapple.is_colliding():
		draw_line(input_vector, to_local(grapple.get_collision_point()), Color("SIENNA"), 3, false)
	else:
		pass
	
func attack_state():
	animationState.travel("Attack")

func grapple_state():
	#print(to_local(grapple.get_collision_point()))
	queue_redraw()
	animationState.travel("Grapple")
	if grapple.is_colliding():
		#velocity = input_vector * to_local(grapple.get_collision_point() )
		input_vector = lerp(input_vector, to_local(grapple.get_collision_point()), 0.003)
		move()
		#grapple_tipper()
	else:
		pass

#func grapple_tipper():
	#if grapple_instanced == false:
		#var grapple_tip_instance = grapple_tip.instantiate()
		#grapple_tip_instance.rotation = grapple_pivot.rotation
		#grapple_tip_instance.global_position = to_local(grapple.get_collision_point())
		#add_child(grapple_tip_instance)
		#grapple_instanced = true
	#else:
		#pass

	
func move():
	velocity = input_vector * move_speed
	move_and_slide()

func attack_animation_finished():
	state = MOVE

func roll_animation_finished():
	state = MOVE

func grapple_animation_finished():
	queue_redraw()
	state = MOVE
	
	

func _on_hurtbox_area_entered(_area) -> void:
	stats.health -= 1
	hurtbox.start_invincibility(0.7)
	hit_flash_anim_player.play("hit_flash")
	hurtbox.create_hit_effect()
