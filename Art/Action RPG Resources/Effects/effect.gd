extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("animation_finished", Callable(self, "_on_animated_sprite_2d_animation_finished"))
	frame = 0
	play("animate")
	
	
func _on_animated_sprite_2d_animation_finished():
	queue_free()
