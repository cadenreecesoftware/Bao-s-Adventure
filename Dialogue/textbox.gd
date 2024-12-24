extends Control

const CHAR_READ_RATE = 0.5
@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var text = $TextboxContainer/MarginContainer/HBoxContainer/Text

var current_state = State.READY
var text_queue = []
enum State {
	READY,
	READING,
	FINISHED
}

func change_state(next_state):
	current_state = next_state

func _ready() -> void:
	hide_textbox()

	
func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	text.text = ""
	textbox_container.hide()
	
	
func queue_text(next_text):
	text_queue.push_back(next_text)
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():

	var next_text = text_queue.pop_front()
	text.text = next_text
	change_state(State.READING)
	show_textbox()

	text.visible_ratio = 0
	var tween = create_tween()
	tween.tween_property(text, "visible_ratio", 1, 1)
	end_symbol.text = "v"
	if tween.is_running() and Input.is_action_just_pressed("interact"):
		tween.kill()
		end_symbol.text = "v"
		current_state = State.FINISHED
		

func _process(delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("interact"):
				end_symbol.text = "v"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("interact"):
				change_state(State.READY)
				hide_textbox()
