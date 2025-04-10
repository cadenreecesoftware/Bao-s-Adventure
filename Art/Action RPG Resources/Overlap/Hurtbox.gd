extends Area2D


const HitEffect = preload("res://Enemies/hit_effect.tscn")

@onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

var invincible = false :
	get: 
		return invincible
	set(value):
		invincible = value
		if invincible == true:
			emit_signal("invincibility_started")
		else:
			emit_signal("invincibility_ended")

func start_invincibility(duration):
	if(PlayerStats.health > 0):
		self.invincible = true
		timer.start(duration)
	

func create_hit_effect() -> void:
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_timer_timeout() -> void:
	self.invincible = false


func _on_invincibility_started() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	

func _on_invincibility_ended() -> void:
	monitoring = true
	monitorable = true
