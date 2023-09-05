extends Control

# This script for directing users into another scene

var level_selection = "res://offline_levels/level_selection/level_selection.tscn"

func _ready():
	pass # Replace with function body.



func _on_offline_button_pressed():
	get_tree().change_scene(level_selection)
