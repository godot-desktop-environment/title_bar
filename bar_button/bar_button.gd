extends Button


## Signal when the button is pressed without leaving the button.
signal pressed_without_leaving

var _left_once: bool = false


func _ready() -> void:
	button_down.connect(_on_button_down)
	gui_input.connect(_on_gui_input)
	mouse_exited.connect(_on_mouse_exited)
	
	mouse_filter = Control.MOUSE_FILTER_PASS


func _pressed() -> void:
	if not _left_once:
		pressed_without_leaving.emit()


func _on_button_down() -> void:
	_left_once = false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if not _left_once:
			get_viewport().set_input_as_handled()


func _on_mouse_exited() -> void:
	if button_pressed:
		_left_once = true
