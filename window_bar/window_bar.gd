extends PanelContainer


var _is_dragging: bool

var _drag_start_position: Vector2i

var _drag_adjustment: float = 0


func _init() -> void:
	gui_input.connect(_on_gui_input)
	resized.connect(_on_resized)


func _on_dragged() -> void:
	match get_window().mode:
		Window.MODE_WINDOWED:
			get_window().position += get_global_mouse_position() as Vector2i - _drag_start_position
		Window.MODE_MAXIMIZED:
			_drag_adjustment = get_global_mouse_position().x / get_window().size.x
			get_window().mode = Window.MODE_WINDOWED


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_on_mouse_button(event)
	elif event is InputEventMouseMotion:
		_on_mouse_motion(event)


func _on_double_clicked() -> void:
	match get_window().mode:
		Window.MODE_MAXIMIZED:
			get_window().mode = Window.MODE_WINDOWED
		_:
			get_window().mode = Window.MODE_MAXIMIZED


func _on_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_on_double_clicked()
	elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_is_dragging = true
		_drag_start_position = get_global_mouse_position()
	elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_is_dragging = false


func _on_mouse_motion(_event: InputEventMouseMotion) -> void:
	if _is_dragging:
		_on_dragged()


func _on_resized() -> void:
	if _drag_adjustment != 0:
		get_window().position += (get_global_mouse_position() as Vector2i)
		get_window().position.x -= (get_window().size.x * _drag_adjustment) as int
		_drag_start_position = get_global_mouse_position()
		_drag_adjustment = 0
