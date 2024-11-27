extends Node2D

@onready var animatedSprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play("Animate")
	

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free() # Replace with function body.
