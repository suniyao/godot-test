extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/StartSymbol
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/EndSymbol
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

@onready var CHAR_READ_RATE = 0.03
@onready var tween = create_tween()

enum State {
	READY,
	READING, 
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready() -> void:
	print("starting state: State.READY")
	hide_textbox()
	queue_text("knock knock knock")
	queue_text("second text to be added")
	queue_text("third text to be added")
	queue_text("fourth text to be added")
	queue_text("fifth text to be added")
	
	
	
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				tween.stop()
				end_symbol.text = ">"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)
	

func hide_textbox() -> void:
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox() -> void:
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	var duration = next_text.length() * CHAR_READ_RATE
	label.visible_ratio = 0
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(self, "_on_text_finished"))

func _on_text_finished() -> void:
	end_symbol.text = ">"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print('change state to State.READY')
		State.READING:
			print('change state to State.READING')
		State.FINISHED:
			print('change state to State.FINISHED')
