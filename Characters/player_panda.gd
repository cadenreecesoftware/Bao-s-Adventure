extends CharacterBody2D


enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

@export var move_speed : float = 100
#@export var starting_direction : Vector2= Vector2(0,1)
@onready var animations = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")



#parameters/Walk/blend_position


func _ready():
	animationTree.active = true


func _physics_process(_delta):
	match state:
		MOVE: 
			move_state()
		ROLL:
			pass
		ATTACK:
			attack_state()
	
	
func move_state():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	velocity = input_vector * move_speed
	move_and_slide()
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	
	
func attack_state():
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

	
	

			
