extends CharacterBody2D


enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var roll_vector = Vector2.LEFT
var input_vector = Vector2.ZERO
var stats = PlayerStats


@export var move_speed : float = 75
@export var roll_speed : float = 1.5
#@export var starting_direction : Vector2= Vector2(0,1)
@onready var animations = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var hurtbox = $Hurtbox
@onready var animationState = animationTree.get("parameters/playback")
@onready var hit_flash_anim_player = $HitFlashAnimationPlayer



#parameters/Walk/blend_position


func _ready():
	self.stats.connect("no_health", queue_free)
	animationTree.active = true


func _physics_process(_delta):
	match state:
		MOVE: 
			move_state()
		ROLL:
			roll_state()
		ATTACK:
			attack_state()
	
	
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
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
func roll_state():
	input_vector = roll_vector * roll_speed
	animationState.travel("Roll")
	#make the player have i-frames during their dodge
	hurtbox.start_invincibility(0.5)
	move()
	
func attack_state():
	animationState.travel("Attack")

func move():
	velocity = input_vector * move_speed
	move_and_slide()

func attack_animation_finished():
	state = MOVE

func roll_animation_finished():
	state = MOVE
	
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= 1
	hurtbox.start_invincibility(0.7)
	hit_flash_anim_player.play("hit_flash")
	hurtbox.create_hit_effect()
