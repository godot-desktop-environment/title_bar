extends Button


## Signal when the button is pressed without leaving the button.
signal pressed_without_leaving

## Signal when the mouse leave the button without releasing it.
signal mouse_exited_without_releasing

var _left_once: bool = false


func _ready() -> void:
	button_down.connect(_on_button_down)
	mouse_exited.connect(_on_mouse_exited)


func _pressed() -> void:
	if not _left_once:
		pressed_without_leaving.emit()


func _on_button_down() -> void:
	_left_once = false


func _on_mouse_exited() -> void:
	if button_pressed:
		_left_once = true
		
		mouse_exited_without_releasing.emit()
