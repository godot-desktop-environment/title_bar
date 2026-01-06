@tool
extends "./window_bar/window_bar.gd"


signal close_pressed

signal maximize_pressed

signal minimize_pressed

signal restore_pressed

enum AlignmentMode {
	BEGIN,
	END
}

@export var buttons_alignment: AlignmentMode = AlignmentMode.END:
	set(a):
		buttons_alignment = a
		
		if a == AlignmentMode.BEGIN:
			%Title.move_to_front()
			%ControlsSpace.move_to_front()
			%CloseButton.move_to_front()
			%MaximizeButton.move_to_front()
			%RestoreButton.move_to_front()
			%MinimizeButton.move_to_front()
			%ButtonsSpace.move_to_front()
		else:
			%Title.move_to_front()
			%ButtonsContainer.move_to_front()
			%ButtonsSpace.move_to_front()
			%MinimizeButton.move_to_front()
			%RestoreButton.move_to_front()
			%MaximizeButton.move_to_front()
			%CloseButton.move_to_front()

@export var title: String = "Window Title":
	set(t):
		%Title.text = t
	get:
		return %Title.text

@export_group("Visibility", "visibility_")

@export var visibility_close_button: bool = true:
	set(v):
		%CloseButton.visible = v
	get:
		return %CloseButton.visible

@export var visibility_maximize_restore_button: bool = true:
	set(v):
		%MaximizeButton.visible = v
	get:
		return %MaximizeButton.visible

@export var visibility_minimize_button: bool = true:
	set(v):
		%MinimizeButton.visible = v
	get:
		return %MinimizeButton.visible


func _on_close_button_pressed() -> void:
	close_pressed.emit()


func _on_maximize_button_pressed() -> void:
	maximize_pressed.emit()


func _on_minimize_button_pressed() -> void:
	minimize_pressed.emit()


func _on_restore_button_pressed() -> void:
	restore_pressed.emit()
