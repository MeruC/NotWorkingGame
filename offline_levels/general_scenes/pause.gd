extends Control

export(NodePath) onready var pause_popup = get_node(pause_popup) as Control
var home_screen = "res://main_screen/main_screen.tscn"

func _ready():
	pass

func _on_pause_button_pressed():
	pause_popup.visible = true


func _on_home_pressed():
	get_tree().change_scene(home_screen)
