extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 150
@onready var animations = $AnimationPlayer
@onready var sound = $AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	speed = 0
	animations.play("stone_break")
	sound.play()	


func _on_area_entered(area: Area2D) -> void:
	speed = 0
	sound.play()
	animations.play("stone_break")
