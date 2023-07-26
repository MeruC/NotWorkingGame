extends Control

export(NodePath) onready var settings = get_node(settings) as Control

func _on_settingsBtn_pressed():
	Global.e_mode_history = Global.editor_mode
	Global.editor_mode = "menu"
	settings.visible = !settings.visible
	settings.raise()
