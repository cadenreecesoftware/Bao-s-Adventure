extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animations = $AnimationPlayer

func _ready():
	color_rect.visible = false
	animations.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animations.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
	

func transition():
	color_rect.visible = true
	animations.play("fade_to_black")
