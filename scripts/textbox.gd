extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/StartSymbol
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/EndSymbol
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

func _ready() -> void:
	hide_textbox()
	add_text("this text is going to be added")
	
func hide_textbox() -> void:
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox() -> void:
	start_symbol.text = "*"
	textbox_container.show()
	
func add_text(next_text) -> void:
	label.text = next_text
	show_textbox()
