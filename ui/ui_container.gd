extends Control

export(NodePath) onready var settings = get_node(settings) as Control
export(NodePath) onready var split_stack = get_node(split_stack) as Control

func _on_settings_pressed():
	if (split_stack.visible):
		split_stack.visible = false
	settings.visible = !settings.visible
	settings.raise()


func _on_exit_pressed():
	get_tree().quit()
