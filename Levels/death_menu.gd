extends Control

#@onready var player = $"../../PlayerPanda"
@onready var animations = $AnimationPlayer
@onready var noises = $AudioStreamPlayer

func _ready():
	animations.play("RESET")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerStats.health == 0  and !get_tree().paused:
		pause()

func pause():
	get_tree().paused = true
	visible = true
	animations.play("blur")

func _on_quit_pressed() -> void:
	noises.play()
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")
	
#func _on_load_pressed() -> void:
	#noises.play()
	#load_game()
