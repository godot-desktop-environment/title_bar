@tool
extends "./window_bar/window_bar.gd"


signal close_pressed

enum AlignmentMode {
	BEGIN,
	END
}

@export var buttons_alignment: AlignmentMode = AlignmentMode.END:
	set(a):
		buttons_alignment = a
		
		if a == AlignmentMode.BEGIN:
			%Title.move_to_front()
			%CloseButton.move_to_front()
			%MaximizeButton.move_to_front()
			%RestoreButton.move_to_front()
			%MinimizeButton.move_to_front()
			%ButtonsContainer.alignment = %ButtonsContainer.ALIGNMENT_BEGIN
		else:
			%ButtonsContainer.move_to_front()
			%MinimizeButton.move_to_front()
			%RestoreButton.move_to_front()
			%MaximizeButton.move_to_front()
			%CloseButton.move_to_front()
			%ButtonsContainer.alignment = %ButtonsContainer.ALIGNMENT_END

@export var title: String = "Window Title":
	set(t):
		%Title.text = t
	get:
		return %Title.text

@export_group("Visibility", "visibility_")

@export var visibility_close_button: bool = true:
	set(v):
		(func(): %CloseButton.visible = v).call_deferred()
	get:
		return %CloseButton.visible

@export var visibility_maximize_restore_button: bool = true:
	set(v):
		(func(): %MaximizeButton.visible = v).call_deferred()
	get:
		return %MaximizeButton.visible

@export var visibility_minimize_button: bool = true:
	set(v):
		(func(): %MinimizeButton.visible = v).call_deferred()
	get:
		return %MinimizeButton.visible


#region Buttons pressed
func _on_close_button_pressed_without_leaving() -> void:
	close_pressed.emit()


func _on_maximize_button_pressed_without_leaving() -> void:
	get_window().mode = Window.MODE_MAXIMIZED


func _on_minimize_button_pressed_without_leaving() -> void:
	get_window().mode = Window.MODE_MINIMIZED


func _on_restore_button_pressed_without_leaving() -> void:
	get_window().mode = Window.MODE_WINDOWED
#endregion


func _on_resized() -> void:
	super._on_resized()
	
	match get_window().mode:
		Window.MODE_MAXIMIZED:
			%MaximizeButton.visible = false
			%RestoreButton.visible = true
		_:
			%MaximizeButton.visible = true
			%RestoreButton.visible = false
