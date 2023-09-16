extends LineEdit

func _on_level_name_gui_input(event):
	if event.is_action_pressed("mouse_button_left"):
		text = ""
