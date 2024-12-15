extends Control

@onready var animations = $AnimationPlayer
@onready var noises = $AudioStreamPlayer

func _ready():
	animations.play("RESET")

# Called when the node enters the scene tree for the first time.
func resume():
	get_tree().paused = false
	visible = false
	animations.play_backwards("blur")

	
func save():
	pass

func pause():
	get_tree().paused = true
	visible = true
	animations.play("blur")
	
	
func pausePressed():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_resume_pressed() -> void:
	resume()
	noises.play()
	
func _on_save_pressed() -> void:
	noises.play()

func _on_quit_pressed() -> void:
	resume()
	noises.play()
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")
	
	
func _process(delta: float) -> void:
	pausePressed()
